
<!-- README.md is generated from README.Rmd. Please edit that file -->

# adm

<!-- badges: start -->
<!-- badges: end -->

The goal of adm is to **a**utomate **d**ata **m**odels created with the
[dm](https://CRAN.R-project.org/package=dm) package. It guesses primary
and foreign keys assuming the names of the tables and keys follow three
rules:

1.  For each table, the primary key has the same name as the table with
    the prefix `_id`. For example the table `x` has a primary key named
    `x_id`.

2.  If an `_id` column exists in a table which name is different than
    the prefix of that `_id` column, then that column is a foreign key
    linking to another table. For example, in the table `x_id`, the
    column `y_id` is a foreign key linking to the table `y`.

3.  If a table links two other tables, its name contains the names of
    those tables. For example, the table `x_y` links the tables `x` and
    `y`.

## Installation

You can install the development version of adm from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("maurolepore/adm")
```

## Example

``` r
library(adm)
library(dm, warn.conflicts = FALSE)

example_dataset <- adm::abcd()
```

Consider this data model. It has the “adm” structure but no keys:

``` r
# Removing keys
dm <- dm::dm(!!!as.list(example_dataset))

dm
#> ── Metadata ────────────────────────────────────────────────────────────────────
#> Tables: `a`, `a_b`, `b`, `b_c`, `c`, `d`
#> Columns: 15
#> Primary keys: 0
#> Foreign keys: 0
```

-   `adm::add_keys()` adds the keys.

``` r
adm <- dm |> adm::add_keys()
adm
#> ── Metadata ────────────────────────────────────────────────────────────────────
#> Tables: `a`, `a_b`, `b`, `b_c`, `c`, `d`
#> Columns: 15
#> Primary keys: 6
#> Foreign keys: 5

adm |> dm::dm_draw()
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

-   `adm::flatten()` flattens all linked tables in a data model into
    single table.

``` r
adm |> adm::flatten()
#> Joining with `by = join_by(b_id, b)`
#> # A tibble: 1 × 10
#>    a_id     a a_b_id  b_id     b b_c_id  c_id     c  d_id     d
#>   <dbl> <dbl>  <dbl> <dbl> <dbl>  <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1     1     1      1     1     1      1     1     1     1     1
```

The non-automatic method is more complex.

``` r
flat1 <- adm |> dm::dm_flatten_to_tbl(.start = a_b)
flat2 <- adm |> dm::dm_flatten_to_tbl(.start = b_c, .recursive = TRUE)
dplyr::left_join(flat1, flat2)
#> Joining with `by = join_by(b_id, b)`
#> # A tibble: 1 × 10
#>   a_b_id  a_id  b_id     a     b b_c_id  c_id     c  d_id     d
#>    <dbl> <dbl> <dbl> <dbl> <dbl>  <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1      1     1     1     1     1      1     1     1     1     1
```

For anything else use the [dm](https://dm.cynkra.com/) package directly.
