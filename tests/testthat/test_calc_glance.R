context("glance_fits")
library(dplyr)

test_that("glance_fits correctly returns broom::glance output", {
  ## Reference
  set.seed(100)
  x1 = 2 + rnorm(10)
  x2 = x1 + rnorm(10)

  broom_target = broom::glance(lm(x2 ~ x1))

  ## glance_fits
  set.seed(100)
  lin_test = blueprint(y1 = ~ 2 + rnorm(10),
            y2 = ~ y1 + rnorm(10)) %>%
    produce(1) %>%
    fit(linear = ~ lm(y2 ~ y1, data = .)) %>%
    glance_fits

  lin_test %>%
    select(-rep, -Source) %>%
    as_tibble %>%
    expect_identical(broom_target)

})

