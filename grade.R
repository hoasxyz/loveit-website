library(pacman)
p_load(readxl, ggthemes, ggtech)

# data input and manipulation ---------------------------------------------

grade <- read_xlsx("E:\\1R\\website\\Excel\\mygrade.xlsx")

grade %<>%
  remove_empty("cols") %>%
  filter(!is.na(成绩)) %>%
  as_tibble()

colnames(grade) <- c(
  "course name", "course type", "course credit",
  "teacher name", "academy", "study type",
  "school year", "semester", "score"
)
grade %<>%
  clean_names("lower_camel") %>% 
  purrr::modify_at(c('courseType', 'schoolYear'), as.factor)

skimr::skim(grade)

grade %<>%
  mutate(
    scoreWeight = score * courseCredit,
    GPA = NA
  ) %>%
  within({
    for (i in seq_along(score)) {
      if (score[i] >= 90) {
        GPA[i] <- 4.0
      } else if (all(85 <= score[i], score[i] < 90)) {
        GPA[i] <- 3.7
      } else if (all(82 <= score[i], score[i] < 85)) {
        GPA[i] <- 3.3
      } else if (all(78 <= score[i], score[i] < 82)) {
        GPA[i] <- 3.0
      } else if (all(75 <= score[i], score[i] < 78)) {
        GPA[i] <- 2.7
      } else if (all(72 <= score[i], score[i] < 75)) {
        GPA[i] <- 2.3
      } else if (all(68 <= score[i], score[i] < 72)) {
        GPA[i] <- 2.0
      } else if (all(64 <= score[i], score[i] < 68)) {
        GPA[i] <- 1.5
      } else if (all(60 <= score[i], score[i] < 64)) {
        GPA[i] <- 1.0
      } else {
        GPA[i] <- 0
      }
    }
  }) %>%
  select(-i) %>%
  mutate(GPAWeight = GPA * courseCredit)

grade %>% 
  filter(courseType != '公共选修') %>% 
  with({
    GPA <<- sum(GPAWeight) / sum(courseCredit)
    totalCredit <<- sum(courseCredit)
    averageScore <<- sum(scoreWeight) / sum(courseCredit)
  })

sum(grade_2018$GPAWeight) / sum(grade_2018$courseCredit)

sum(grade$GPAWeight) / sum(grade$courseCredit)



grade_2018 <- grade %>% 
  filter(schoolYear == 2018 & courseType != '公共选修')

sum(grade_2018$scoreWeight) / sum(grade_2018$courseCredit)
# overview ----------------------------------------------------------------

grade %>%
  group_by(courseType) %>%
  summarise(score = sum(scoreWeight) / sum(courseCredit)) %>%
  ungroup() %>%
  ggplot(aes(courseType, score)) +
  theme_gdocs() +
  geom_bar(aes(fill = courseType), stat = "identity", show.legend = FALSE) +
  geom_text(aes(label = format(score, digits = 4)),
    vjust = -.5
  ) +
  ylim(0, 100) +
  labs(title = "Average Score of Different Course Type")

grade %>%
  group_by(courseType) %>%
  summarise(GPA = sum(GPAWeight) / sum(courseCredit)) %>%
  ungroup() %>%
  ggplot(aes(courseType, GPA)) +
  theme_gdocs() +
  geom_bar(aes(fill = courseType), stat = "identity", show.legend = FALSE) +
  geom_text(aes(label = format(GPA, digits = 4)),
    vjust = -.5
  ) +
  ylim(0, 4) +
  labs(title = "Average GPA of Different Course Type")

grade %>%
  group_by(schoolYear) %>%
  summarise(score = sum(scoreWeight) / sum(courseCredit)) %>%
  ungroup() %>%
  ggplot(aes(schoolYear, score)) +
  theme_gdocs() +
  geom_bar(aes(fill = schoolYear), stat = "identity", show.legend = FALSE) +
  geom_text(aes(label = format(score, digits = 4)),
    vjust = -.5
  ) +
  ylim(0, 100) +
  labs(title = "Average Score of Different School Year")

grade %>%
  group_by(schoolYear) %>%
  summarise(GPA = sum(GPAWeight) / sum(courseCredit)) %>%
  ungroup() %>%
  ggplot(aes(schoolYear, GPA)) +
  theme_gdocs() +
  geom_bar(aes(fill = schoolYear), stat = "identity", show.legend = FALSE) +
  geom_text(aes(label = format(GPA, digits = 4)),
    vjust = -.5
  ) +
  ylim(0, 4) +
  labs(title = "Average GPA of Different School Year")

grade %>%
  group_by(GPA, courseType) %>%
  summarise(count = n()) %>%
  ungroup() %>%
  ggplot(aes(GPA, count, fill = courseType)) +
  theme_gdocs() +
  geom_col() +
  geom_text(aes(label = count),
    vjust = 1, position = position_stack()
  ) +
  scale_x_continuous(
    breaks = c(2.3, 3, 3.3, 3.7, 4),
    labels = c("2.3", "3.0", "3.3", "3.7", "4.0")
  ) +
  ylim(0, 45) +
  labs(title = "The GPA Distribution")


# got stuck ---------------------------------------------------------------

stuck <- c(89, 84, 81, 77, 74, 71, 67, 63, 59)

# Times
grade %>%
  filter(score %in% stuck) %>%
  group_by(courseCredit, courseType) %>%
  summarise(count = n()) %>%
  ungroup() %>%
  # pay attention to the arrange of course credit!
  arrange(desc(courseCredit)) %>%
  ggplot(aes(courseType, count)) +
  theme_gdocs() +
  geom_col(aes(fill = as.factor(courseCredit))) +
  labs(title = "Times of Getting Stuck by Course Type") +
  geom_text(aes(label = count),
            vjust = 1, position = position_stack()
  )

grade %>%
  filter(score %in% stuck) %>%
  group_by(courseCredit, schoolYear) %>%
  summarise(count = n()) %>%
  ungroup() %>%
  arrange(desc(courseCredit)) %>%
  ggplot(aes(schoolYear, count)) +
  theme_gdocs() +
  geom_col(aes(fill = as.factor(courseCredit))) +
  labs(title = "Times of Getting Stuck by School Year") +
  geom_text(aes(label = count),
            vjust = 1, position = position_stack()
  )

# Total credit
grade %>%
  filter(score %in% stuck) %>%
  group_by(courseCredit, courseType) %>%
  summarise(count = n()) %>%
  ungroup() %>%
  arrange(desc(courseCredit)) %>%
  ggplot(aes(courseCredit, count)) +
  theme_gdocs() +
  geom_col(aes(fill = courseType)) +
  labs(title = "Times of Getting Stuck by Course Type") +
  geom_text(aes(label = count),
            vjust = 1, position = position_stack()
  )

