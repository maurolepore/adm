
<!-- README.md is generated from README.Rmd. Please edit that file -->

# adm

<!-- badges: start -->

[![R-CMD-check](https://github.com/maurolepore/adm/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/maurolepore/adm/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of adm is to provide **a**utomated tools to work with **d**ata
**m**odels. It’s enabled by a lightweight convention on top of the
[dm](https://CRAN.R-project.org/package=dm) package. Your data model
must follow only two rules:

1.  For each table, the primary key has the same name as the table with
    the prefix `_id`. For example the table `x` has a primary key named
    `x_id`.

2.  If an `_id` column exists in a table which name is different than
    the prefix of that `_id` column, then that column is a foreign key
    linking to another table. For example, in the table `x_id`, the
    column `y_id` is a foreign key linking to the table `y`.

## Installation

You can install the development version of adm from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("maurolepore/adm")
```

## Example

``` r
library(dm, warn.conflicts = FALSE)
library(adm)
```

Consider this data model. The table and column names follow the three
rules above, but the data model has no key yet.

``` r
adm_example <- adm_demo()
# Removing keys to show how to add them
dm <- dm(!!!as.list(adm_example))
dm
#> ── Metadata ────────────────────────────────────────────────────────────────────
#> Tables: `a`, `a_b`, `b`, `b_c`, `c`, … (7 total)
#> Columns: 17
#> Primary keys: 0
#> Foreign keys: 0
```

- `adm::add_keys()` adds primary and foreign keys.

``` r
adm <- dm %>% add_keys()
adm
#> ── Metadata ────────────────────────────────────────────────────────────────────
#> Tables: `a`, `a_b`, `b`, `b_c`, `c`, … (7 total)
#> Columns: 17
#> Primary keys: 7
#> Foreign keys: 5

adm %>% dm_draw()
```

<div class="grViz html-widget html-fill-item" id="htmlwidget-9af2622c317bcab2fdc0" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-9af2622c317bcab2fdc0">{"x":{"diagram":"#data_model\ndigraph {\ngraph [rankdir=LR tooltip=\"Data Model\" ]\n\nnode [margin=0 fontcolor = \"#444444\" ]\n\nedge [color = \"#555555\", arrowsize = 1, ]\n\npack=true\npackmode= \"node\"\n\n  \"a\" [id = \"a\", label = <<TABLE ALIGN=\"LEFT\" BORDER=\"1\" CELLBORDER=\"0\" CELLSPACING=\"0\" COLOR=\"#555555\">\n    <TR>\n      <TD COLSPAN=\"1\" BGCOLOR=\"#EFEBDD\" BORDER=\"0\"><FONT COLOR=\"#000000\">a<\/FONT>\n<\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"a_id\"><U>a_id<\/U><\/TD>\n    <\/TR>\n  <\/TABLE>>, shape = \"plaintext\"] \n\n  \"a_b\" [id = \"a_b\", label = <<TABLE ALIGN=\"LEFT\" BORDER=\"1\" CELLBORDER=\"0\" CELLSPACING=\"0\" COLOR=\"#555555\">\n    <TR>\n      <TD COLSPAN=\"1\" BGCOLOR=\"#EFEBDD\" BORDER=\"0\"><FONT COLOR=\"#000000\">a_b<\/FONT>\n<\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"a_b_id\"><U>a_b_id<\/U><\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"a_id\">a_id<\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"b_id\">b_id<\/TD>\n    <\/TR>\n  <\/TABLE>>, shape = \"plaintext\"] \n\n  \"b\" [id = \"b\", label = <<TABLE ALIGN=\"LEFT\" BORDER=\"1\" CELLBORDER=\"0\" CELLSPACING=\"0\" COLOR=\"#555555\">\n    <TR>\n      <TD COLSPAN=\"1\" BGCOLOR=\"#EFEBDD\" BORDER=\"0\"><FONT COLOR=\"#000000\">b<\/FONT>\n<\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"b_id\"><U>b_id<\/U><\/TD>\n    <\/TR>\n  <\/TABLE>>, shape = \"plaintext\"] \n\n  \"b_c\" [id = \"b_c\", label = <<TABLE ALIGN=\"LEFT\" BORDER=\"1\" CELLBORDER=\"0\" CELLSPACING=\"0\" COLOR=\"#555555\">\n    <TR>\n      <TD COLSPAN=\"1\" BGCOLOR=\"#EFEBDD\" BORDER=\"0\"><FONT COLOR=\"#000000\">b_c<\/FONT>\n<\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"b_c_id\"><U>b_c_id<\/U><\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"b_id\">b_id<\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"c_id\">c_id<\/TD>\n    <\/TR>\n  <\/TABLE>>, shape = \"plaintext\"] \n\n  \"c\" [id = \"c\", label = <<TABLE ALIGN=\"LEFT\" BORDER=\"1\" CELLBORDER=\"0\" CELLSPACING=\"0\" COLOR=\"#555555\">\n    <TR>\n      <TD COLSPAN=\"1\" BGCOLOR=\"#EFEBDD\" BORDER=\"0\"><FONT COLOR=\"#000000\">c<\/FONT>\n<\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"c_id\"><U>c_id<\/U><\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"d_id\">d_id<\/TD>\n    <\/TR>\n  <\/TABLE>>, shape = \"plaintext\"] \n\n  \"d\" [id = \"d\", label = <<TABLE ALIGN=\"LEFT\" BORDER=\"1\" CELLBORDER=\"0\" CELLSPACING=\"0\" COLOR=\"#555555\">\n    <TR>\n      <TD COLSPAN=\"1\" BGCOLOR=\"#EFEBDD\" BORDER=\"0\"><FONT COLOR=\"#000000\">d<\/FONT>\n<\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"d_id\"><U>d_id<\/U><\/TD>\n    <\/TR>\n  <\/TABLE>>, shape = \"plaintext\"] \n\n  \"e\" [id = \"e\", label = <<TABLE ALIGN=\"LEFT\" BORDER=\"1\" CELLBORDER=\"0\" CELLSPACING=\"0\" COLOR=\"#555555\">\n    <TR>\n      <TD COLSPAN=\"1\" BGCOLOR=\"#EFEBDD\" BORDER=\"0\"><FONT COLOR=\"#000000\">e<\/FONT>\n<\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"e_id\"><U>e_id<\/U><\/TD>\n    <\/TR>\n  <\/TABLE>>, shape = \"plaintext\"] \n\n\"a_b\":\"a_id\"->\"a\":\"a_id\" [id=\"a_b_1\"]\n\"a_b\":\"b_id\"->\"b\":\"b_id\" [id=\"a_b_2\"]\n\"b_c\":\"b_id\"->\"b\":\"b_id\" [id=\"b_c_1\"]\n\"b_c\":\"c_id\"->\"c\":\"c_id\" [id=\"b_c_2\"]\n\"c\":\"d_id\"->\"d\":\"d_id\" [id=\"c_1\"]\n}","config":{"engine":null,"options":null}},"evals":[],"jsHooks":[]}</script>

- `adm::flatten_linked_tables()` flattens linked tables in a single one.
  Unlinked tables are excluded because there is no way to join them.

``` r
adm %>% flatten_linked_tables()
#> Warning: Unlinked tables: e
#> Joining with `by = join_by(b_id)`
#> Joining with `by = join_by(c_id)`
#> Joining with `by = join_by(a_id)`
#> Joining with `by = join_by(b_id)`
#> Joining with `by = join_by(d_id)`
#> # A tibble: 1 × 10
#>    a_id     a a_b_id  b_id     b b_c_id  c_id     c  d_id     d
#>   <dbl> <dbl>  <dbl> <dbl> <dbl>  <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1     1     1      1     1     1      1     1     1     1     1
```

### Without adm

You can do the same directly with the [dm](https://dm.cynkra.com/)
package, but with complex data models it’s hard work.

- Add primary and foreign keys.

``` r
dm2 <- dm %>%
  dm_add_pk(a, a_id) %>%
  dm_add_pk(a_b, a_b_id) %>%
  dm_add_pk(b, b_id) %>%
  dm_add_pk(b_c, b_c_id) %>%
  dm_add_pk(c, c_id) %>%
  dm_add_pk(d, d_id) %>%
  dm_add_pk(e, e_id) %>%
  dm_add_fk(a_b, a_id, a) %>%
  dm_add_fk(a_b, b_id, b) %>%
  dm_add_fk(b_c, b_id, b) %>%
  dm_add_fk(b_c, c_id, c) %>%
  dm_add_fk(c, d_id, d)
dm2
#> ── Metadata ────────────────────────────────────────────────────────────────────
#> Tables: `a`, `a_b`, `b`, `b_c`, `c`, … (7 total)
#> Columns: 17
#> Primary keys: 7
#> Foreign keys: 5

dm2 %>% dm_draw()
```

<div class="grViz html-widget html-fill-item" id="htmlwidget-c8c6374d33a313bef78f" style="width:100%;height:480px;"></div>
<script type="application/json" data-for="htmlwidget-c8c6374d33a313bef78f">{"x":{"diagram":"#data_model\ndigraph {\ngraph [rankdir=LR tooltip=\"Data Model\" ]\n\nnode [margin=0 fontcolor = \"#444444\" ]\n\nedge [color = \"#555555\", arrowsize = 1, ]\n\npack=true\npackmode= \"node\"\n\n  \"a\" [id = \"a\", label = <<TABLE ALIGN=\"LEFT\" BORDER=\"1\" CELLBORDER=\"0\" CELLSPACING=\"0\" COLOR=\"#555555\">\n    <TR>\n      <TD COLSPAN=\"1\" BGCOLOR=\"#EFEBDD\" BORDER=\"0\"><FONT COLOR=\"#000000\">a<\/FONT>\n<\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"a_id\"><U>a_id<\/U><\/TD>\n    <\/TR>\n  <\/TABLE>>, shape = \"plaintext\"] \n\n  \"a_b\" [id = \"a_b\", label = <<TABLE ALIGN=\"LEFT\" BORDER=\"1\" CELLBORDER=\"0\" CELLSPACING=\"0\" COLOR=\"#555555\">\n    <TR>\n      <TD COLSPAN=\"1\" BGCOLOR=\"#EFEBDD\" BORDER=\"0\"><FONT COLOR=\"#000000\">a_b<\/FONT>\n<\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"a_b_id\"><U>a_b_id<\/U><\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"a_id\">a_id<\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"b_id\">b_id<\/TD>\n    <\/TR>\n  <\/TABLE>>, shape = \"plaintext\"] \n\n  \"b\" [id = \"b\", label = <<TABLE ALIGN=\"LEFT\" BORDER=\"1\" CELLBORDER=\"0\" CELLSPACING=\"0\" COLOR=\"#555555\">\n    <TR>\n      <TD COLSPAN=\"1\" BGCOLOR=\"#EFEBDD\" BORDER=\"0\"><FONT COLOR=\"#000000\">b<\/FONT>\n<\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"b_id\"><U>b_id<\/U><\/TD>\n    <\/TR>\n  <\/TABLE>>, shape = \"plaintext\"] \n\n  \"b_c\" [id = \"b_c\", label = <<TABLE ALIGN=\"LEFT\" BORDER=\"1\" CELLBORDER=\"0\" CELLSPACING=\"0\" COLOR=\"#555555\">\n    <TR>\n      <TD COLSPAN=\"1\" BGCOLOR=\"#EFEBDD\" BORDER=\"0\"><FONT COLOR=\"#000000\">b_c<\/FONT>\n<\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"b_c_id\"><U>b_c_id<\/U><\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"b_id\">b_id<\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"c_id\">c_id<\/TD>\n    <\/TR>\n  <\/TABLE>>, shape = \"plaintext\"] \n\n  \"c\" [id = \"c\", label = <<TABLE ALIGN=\"LEFT\" BORDER=\"1\" CELLBORDER=\"0\" CELLSPACING=\"0\" COLOR=\"#555555\">\n    <TR>\n      <TD COLSPAN=\"1\" BGCOLOR=\"#EFEBDD\" BORDER=\"0\"><FONT COLOR=\"#000000\">c<\/FONT>\n<\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"c_id\"><U>c_id<\/U><\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"d_id\">d_id<\/TD>\n    <\/TR>\n  <\/TABLE>>, shape = \"plaintext\"] \n\n  \"d\" [id = \"d\", label = <<TABLE ALIGN=\"LEFT\" BORDER=\"1\" CELLBORDER=\"0\" CELLSPACING=\"0\" COLOR=\"#555555\">\n    <TR>\n      <TD COLSPAN=\"1\" BGCOLOR=\"#EFEBDD\" BORDER=\"0\"><FONT COLOR=\"#000000\">d<\/FONT>\n<\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"d_id\"><U>d_id<\/U><\/TD>\n    <\/TR>\n  <\/TABLE>>, shape = \"plaintext\"] \n\n  \"e\" [id = \"e\", label = <<TABLE ALIGN=\"LEFT\" BORDER=\"1\" CELLBORDER=\"0\" CELLSPACING=\"0\" COLOR=\"#555555\">\n    <TR>\n      <TD COLSPAN=\"1\" BGCOLOR=\"#EFEBDD\" BORDER=\"0\"><FONT COLOR=\"#000000\">e<\/FONT>\n<\/TD>\n    <\/TR>\n    <TR>\n      <TD ALIGN=\"LEFT\" BGCOLOR=\"#FFFFFF\" PORT=\"e_id\"><U>e_id<\/U><\/TD>\n    <\/TR>\n  <\/TABLE>>, shape = \"plaintext\"] \n\n\"a_b\":\"a_id\"->\"a\":\"a_id\" [id=\"a_b_1\"]\n\"a_b\":\"b_id\"->\"b\":\"b_id\" [id=\"a_b_2\"]\n\"b_c\":\"b_id\"->\"b\":\"b_id\" [id=\"b_c_1\"]\n\"b_c\":\"c_id\"->\"c\":\"c_id\" [id=\"b_c_2\"]\n\"c\":\"d_id\"->\"d\":\"d_id\" [id=\"c_1\"]\n}","config":{"engine":null,"options":null}},"evals":[],"jsHooks":[]}</script>

- Flatten linked tables into a single one.

``` r
flat1 <- dm2 %>% dm_flatten_to_tbl(.start = a_b)
flat2 <- dm2 %>% dm_flatten_to_tbl(.start = b_c, .recursive = TRUE)
left_join(flat1, flat2)
#> Joining with `by = join_by(b_id, b)`
#> # A tibble: 1 × 10
#>   a_b_id  a_id  b_id     a     b b_c_id  c_id     c  d_id     d
#>    <dbl> <dbl> <dbl> <dbl> <dbl>  <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1      1     1     1     1     1      1     1     1     1     1
```
