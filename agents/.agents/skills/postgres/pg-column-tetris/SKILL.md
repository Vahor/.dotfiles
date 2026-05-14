---
name: pg-column-tetris
description: PostgreSQL table design guidance focused on structuring columns to reduce heap row size. Use when creating or reviewing Postgres CREATE TABLE DDL, migrations, schema design, column ordering, row padding, alignment, or table-size optimization.
user-invocable: false
---

# PostgreSQL Column Ordering for Smaller Tables

Use this skill when designing or reviewing PostgreSQL tables where physical row size matters. The goal is to reduce wasted alignment padding by choosing a better physical column order.

## Core principle

PostgreSQL stores row values as a sequence of bytes in physical column order. Column types have different sizes: a `bigint` takes 8 bytes, an `integer` takes 4, and a `boolean` takes 1.

PostgreSQL cannot always pack those values back-to-back. Fixed-width data types require natural alignment: an 8-byte value should start at an offset divisible by 8, a 4-byte value at an offset divisible by 4, a 2-byte value at an offset divisible by 2, and so on. To guarantee this, PostgreSQL inserts invisible padding bytes between columns whenever needed.

Example: placing a `boolean` before a `bigint` can require up to 7 bytes of padding before the `bigint`; placing the `bigint` first avoids that waste. A poor order can waste bytes in every row; on large tables this increases heap size, shared buffer usage, cache pressure, and I/O.

Default rule for new tables:

1. Put fixed-width columns first.
2. Order fixed-width columns by alignment requirement, largest to smallest.
3. Put variable-length columns last.
4. Within the same alignment group, prefer `NOT NULL` columns before nullable columns when it does not hurt readability.

## Practical ordering groups

Use PostgreSQL alignment, not just apparent byte length:

1. **8-byte aligned**: common examples: `bigint`, `bigserial`, `double precision`, `timestamp`, `timestamptz`, `interval`
2. **4-byte aligned**: common examples: `integer`, `serial`, `real`, `date`, `oid`
3. **2-byte aligned**: common examples: `smallint`, `smallserial`
4. **1-byte aligned**: common examples: `boolean`, internal `"char"`; some fixed-size types may also have low alignment despite larger storage
5. **Variable-length / varlena last**: common examples: `text`, `varchar`, `numeric`, `json`, `jsonb`, `bytea`, arrays

For unusual, third-party, enum, domain, or custom types, verify with `pg_type` instead of guessing:

```sql
SELECT typname, typlen, typalign
FROM pg_type
WHERE typname IN ('bigint', 'integer', 'text', 'uuid', 'jsonb');
```

Alignment meanings:

- `d` = 8-byte alignment
- `i` = 4-byte alignment
- `s` = 2-byte alignment
- `c` = 1-byte alignment
- `typlen = -1` = variable-length type

## Example

Suboptimal physical order:

```sql
CREATE TABLE orders (
    is_shipped boolean,
    order_total numeric,
    user_id bigint,
    item_count smallint,
    ordered_at timestamptz,
    status smallint,
    metadata jsonb
);
```

Better physical order for row size:

```sql
CREATE TABLE orders (
    user_id bigint,
    ordered_at timestamptz,
    item_count smallint,
    status smallint,
    is_shipped boolean,
    order_total numeric,
    metadata jsonb
);
```

## Review checklist

When generating or reviewing PostgreSQL DDL:

- Apply this mainly to **new tables** and **high-row-count tables**.
- Put `id`, foreign keys, timestamps, and other 8-byte-aligned values before smaller fixed-width flags and counters.
- Keep `text`, `varchar`, `numeric`, `jsonb`, `bytea`, and arrays near the end unless there is a strong reason not to.
- Preserve constraints, defaults, generated/identity clauses, collations, comments, partitioning, indexes, FKs, triggers, RLS policies, grants, and ownership.
- Use explicit column lists in `INSERT` and migrations so physical column order is not a behavioral dependency.
- Do not reorder purely for tiny lookup/config tables unless the user asks; readability may matter more.
- If domain readability conflicts with compactness, call out the tradeoff instead of silently changing the order.
- Do not promise exact byte savings unless measured.

## Existing tables

PostgreSQL cannot physically reorder existing columns with a normal `ALTER TABLE`. `ALTER TABLE ... ADD COLUMN` appends the column.

To optimize an existing table, you need a rewrite pattern:

1. Create a new table with the desired column order.
2. Copy data using explicit source and destination column lists.
3. Recreate or preserve all schema objects and permissions.
4. Swap names only after verification.

Always ask before proposing or applying a rewrite. Rewrites can take locks, require downtime, and are easy to get wrong.

## Measuring instead of guessing

If a database is available, prefer measurement for existing tables:

```sql
SELECT avg(pg_column_size(t)) AS avg_row_bytes
FROM public.orders AS t;
```

To inspect a type's alignment:

```sql
SELECT n.nspname AS schema,
       t.typname,
       t.typlen,
       t.typalign
FROM pg_type t
JOIN pg_namespace n ON n.oid = t.typnamespace
WHERE t.typname = 'your_type_name';
```

For large tables, compare candidate schemas in a scratch database with representative data before recommending an invasive rewrite.

## Note

This skill is inspired by [`pg_column_tetris`](https://github.com/rogerwelin/pg_column_tetris), which can automate column-order checks. The skill itself is about the underlying PostgreSQL table-structure principle, not about using that extension.
