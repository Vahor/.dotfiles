#!/usr/bin/env bash

# Usage: ./search.sh -q "query" [-n <num>] [--content] [--freshness <period>] [--country <code>]


set -e

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    -q|--query)
      query="$2"
      shift
      ;;
    -n|--num)
      num="$2"
      shift
      ;;
    --content)
      content=true
      ;;
    --freshness)
      freshness="$2"
      shift
      ;;
    --country)
      country="$2"
      shift
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
  shift
done
