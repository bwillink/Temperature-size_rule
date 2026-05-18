prep_rate_dat <-  function(data, group = NULL, dev_rate, growth_rate) {
  if (!is.null(group)) {
    dat_temp <- transform(data, dev_c = ave(dev_rate, group, FUN = scale))
    dat_temp <- transform(dat_temp, growth_c = ave(log(growth_rate), group, FUN =
                                                     scale))
  } else {
    dat_temp <- transform(data, dev_c = ave(dev_rate, FUN = scale))
    dat_temp <- transform(dat_temp, growth_c = ave(log(growth_rate), FUN = scale))
  }
  
  
  # remove the one data point with instantaneous development
  dat_temp <- dat_temp[!is.na(dat_temp$dev_c), ]
  
  #select columns of interest
  dat_l <- dat_temp %>% dplyr::select(c(full_id, species, Instar, acclimation, dev_c, growth_c)) %>%
    # reshape to long format
    pivot_longer(
      cols = c(dev_c, growth_c),
      names_to = "rate",
      values_to = "value"
    ) %>%
    # remove "_c" from strings
    mutate(rate = gsub("_c", "", rate), .keep = "all")
  return(dat_l)
}

plot_raw_rates <- function(data, colors) {
ggplot(data = data, aes(y = value, x = as.numeric(acclimation), color = rate)) +
  geom_point(size = 2) +
  # linear model fit for each trait and species
  geom_smooth(method = "lm",) +
  scale_color_manual(values = colors) +
  # species to separate panels
  facet_grid(species~Instar) +
  theme_light()
}

plot_raw_mass <- function(data, colors) {
  ggplot(data = data, aes(y = z_score, x = as.factor(acclimation))) +
    geom_jitter(size = 2, color = "grey50") +
    geom_boxplot(fill = NA) +
    scale_color_manual(values = colors) +
    # species to separate panels
    facet_grid(species~Instar) +
    theme_light()
}

process_rate_glmm <- function(mcmc, post_n, n_species, n_stages, n_traits, n_temp) {
  dplyr::select(data.frame(mcmc), contains("acclimation")) %>%
    # reshape into long format
    pivot_longer(cols = everything(),
                 names_to = "rate",
                 values_to = "value") %>%
    # shorten strings
    mutate(rate = gsub("species|Instar|rate|acclimation", "", rate)) %>%
    # separate "rate" column into three columns, one for each variable
    separate_wider_delim(
      col = rate,
      delim = ".",
      names = c("species", "instar", "trait", "temp")
    ) %>%
    # sort values by species, trait, and temperature (changed "acclimation" for "temp")
    arrange(species, instar, trait, temp)  %>%
    # add a character to make values into strings
    mutate(temp = paste0("t", temp)) %>%
    # create column for iteration id
    mutate(it = rep(seq(1:post_n), n_species * n_stages *n_traits * n_temp)) %>%
    # make columns for rates at each temp
    pivot_wider(names_from = temp, values_from = value) %>%
    # compute difference in rates between temps (slope)
    mutate(slope = t20 - t10) %>%
    # select columns of interest
    dplyr::select(it, species,instar, trait, slope) %>%
    # make columns for trait-specific slopes
    pivot_wider(names_from = trait, values_from = slope) %>%
    # compute difference in slope between traits
    mutate(rule = dev - growth) %>%
    # create a column to store sign of eact posterior sample
    mutate(sign = ifelse(rule > 0, "expected", "opposite"))
}

process_rate_stage_glmm <- function(mcmc, post_n, n_species, n_stages, n_traits, n_temp) {
  dplyr::select(data.frame(mcmc), contains("acclimation")) %>%
    # reshape into long format
    pivot_longer(cols = everything(),
                 names_to = "rate",
                 values_to = "value") %>%
    # shorten strings
    mutate(rate = gsub("species|Instar|rate|acclimation", "", rate)) %>%
    # separate "rate" column into three columns, one for each variable
    separate_wider_delim(
      col = rate,
      delim = ".",
      names = c("species", "instar", "trait", "temp")
    ) %>%
    # sort values by species, trait, and temperature (changed "acclimation" for "temp")
    arrange(species, instar, trait, temp)  %>%
    # add a character to make values into strings
    mutate(temp = paste0("t", temp)) %>%
    # create column for iteration id
    mutate(it = rep(seq(1:post_n), n_species * n_stages *n_traits * n_temp)) %>%
    # make columns for rates at each temp
    pivot_wider(names_from = instar, values_from = value) %>%
    # compute difference in rates between temps (slope)
    mutate(t1 = fifth - fourth,
           t2 = sixth - fifth) %>%
    # select columns of interest
    dplyr::select(it, species, temp, trait, t1, t2) %>%
    # make columns for trait-specific slopes
    pivot_wider(names_from = trait, values_from = c(t1,t2)) 
}

process_mass_glmm <- function(mcmc, post_n, n_species, n_stages, n_traits, n_temp) {
  dplyr::select(data.frame(mcmc), contains("acclimation")) %>%
    # reshape into long format
    pivot_longer(cols = everything(), names_to = "mass", values_to = "value") %>%
    # shorten strings
    mutate(mass = gsub("species|Instar|acclimation", "", mass)) %>%
    # separate "rate" column into three columns, one for each variable 
    separate_wider_delim(col = mass, delim = ".", names = c("species", "instar","temp")) %>%
    # sort values by species, and temperature (changed "acclimation" for "temp")
    arrange(species, instar, temp)  %>%
    # add a character to make values into strings
    mutate(temp = paste0("t", temp)) %>%
    # create column for iteration id
    mutate(it = rep(seq(1:post_n),n_species*n_stages*n_traits*n_temp)) %>%
    # make columns for rates at each temp
    pivot_wider(names_from = temp, values_from = value) %>%
    # compute difference in rates between temps (slope)
    mutate(diff = t10 - t20) %>%
    # select columns of interest
   dplyr::select(it, species, instar, diff) %>%
    # make columns for trait-specific slopes 
    # pivot_wider(names_from = trait, values_from = diif) %>%
    # compute difference in slope between traits
    # mutate(rule = dev - growth) %>%
    # create a column to store sign of each posterior sample
    mutate(sign = ifelse(diff > 0, "expected", "opposite"))
}

process_mass_stage_glmm <- function(mcmc, post_n, n_species, n_stages, n_traits, n_temp) {
  dplyr::select(data.frame(mcmc), contains("acclimation")) %>%
    # reshape into long format
    pivot_longer(cols = everything(), names_to = "mass", values_to = "value") %>%
    # shorten strings
    mutate(mass = gsub("species|Instar|acclimation", "", mass)) %>%
    # separate "rate" column into three columns, one for each variable 
    separate_wider_delim(col = mass, delim = ".", names = c("species", "instar","temp")) %>%
    # sort values by species, and temperature (changed "acclimation" for "temp")
    arrange(species, instar, temp)  %>%
    # add a character to make values into strings
    mutate(temp = paste0("t", temp)) %>%
    # create column for iteration id
    mutate(it = rep(seq(1:post_n),n_species*n_stages*n_traits*n_temp)) %>%
    # make columns for rates at each stage
    pivot_wider(names_from = instar, values_from = value) %>%
    # compute difference in rates between instars
    mutate(t1 = fifth - fourth,
           t2 = sixth - fifth) %>%
    # select columns of interest
    dplyr::select(it, species, temp, t1, t2)
}

plot_posteriors <-  function(data, x, colors, x_label, low_label, high_label, main) {
  ggplot(data = data, aes(x =x, fill = sign)) +
    facet_grid(species ~instar) +
    geom_histogram(position  = "identity",  color = "white", linewidth = 0.2, bins = 30) +
    theme_minimal(base_size = 9) + 
    theme(legend.position = "top", panel.grid = element_blank(), panel.border = element_rect(color = "gray"), axis.ticks = element_line(color = "grey")) +
    #theme(strip.text.x = element_text(hjust = 0, vjust = 1, margin=margin(l=0))) +
    scale_fill_viridis_d(option = colors, begin = 0.4, end = 0.8,  labels = c(low_label, high_label)) +
    labs(fill = main, x = x_label, y = "Posterior frequency")
}