
# 0 -----------------------------------------------------------------------

.libPaths("E:/R-3.5.2/library")
install.packages("downloader")
library(rmd)
install.packages("recharts",
                 repos = c("http://yihui.name/xran", "http://cran.rstudio.com")
)
options(blogdown.generator.server = TRUE)
blogdown::serve_site()

require(readxl)
require(cowplot)
require(reprex)
require(plyr)
require(reshape2)
require(widgetframe)
library(lubridate)
library("highcharter")
library(data.table)
library(rvest)
library(curl)
library(stringr)
# 1 -----------------------------------------------------------------------

url <- "https://data.weather.gov.hk/gts/time/conversion1_text_c.htm/"
t <- read_html(url)
read_html(curl("http://google.com", handle = curl::new_handle("useragent" = "Mozilla/5.0")))
tb <- read.table("https://data.weather.gov.hk/gts/time/calendar/text/T1901e.txt",
                 header = FALSE, sep = " ", skip = 2, fill = TRUE, encoding = "UTF-8"
)

# t <- read.csv2("./Excel/T2019c.txt",
#               header = FALSE, sep = " ", skip = 3, fileEncoding = "BIG5")

# year <- fread("https://data.weather.gov.hk/gts/time/calendar/text/T2019e.txt",
#              fill = TRUE, header = FALSE, skip = 2)[,1] %>%
#   rename("year" = "V1")

# 读取数据以及初步处理
wd_zh <- read.table("./Excel/T2019c.txt",
                    header = FALSE, sep = " ", skip = 3, fill = TRUE, fileEncoding = "BIG5"
) %>%
  select(V9:V11, V17:V19)

wd_en <- read.table("https://data.weather.gov.hk/gts/time/calendar/text/T2019e.txt",
                    header = FALSE, sep = " ", skip = 2, fill = TRUE
) %>%
  select(V9:V11)

year <- read.table("https://data.weather.gov.hk/gts/time/calendar/text/T2019e.txt",
                   header = FALSE, sep = " ", skip = 2, fill = TRUE
) %>%
  select(V1) %>%
  rename(solar = V1)

year$year <- ymd(year$year)

# 中文更改数据格式
wd_zh$V9 <- as.character(wd_zh$V9)
wd_zh$V10 <- as.character(wd_zh$V10)
wd_zh$V11 <- as.character(wd_zh$V11)
wd_zh$V17 <- as.character(wd_zh$V17)
wd_zh$V18 <- as.character(wd_zh$V18)
wd_zh$V19 <- as.character(wd_zh$V19)

# 英文更改数据格式
wd_en$V9 <- as.character(wd_en$V9)
wd_en$V10 <- as.character(wd_en$V10)
wd_en$V11 <- as.character(wd_en$V11)

# 中文空白合并以及合并后处理
for (i in seq_along(wd_zh[[1]])) {
  if (wd_zh[[1]][i] == "") {
    if (wd_zh[[2]][i] != "") {
      wd_zh[[1]][i] <- wd_zh[[2]][i]
    } else {
      wd_zh[[1]][i] <- wd_zh[[3]][i]
    }
  } else {
    wd_zh[[1]][i] <- wd_zh[[1]][i]
  }
  
  if (wd_zh[[4]][i] == "") {
    if (wd_zh[[5]][i] != "") {
      wd_zh[[4]][i] <- wd_zh[[5]][i]
    } else {
      wd_zh[[4]][i] <- wd_zh[[6]][i]
    }
  } else {
    wd_zh[[4]][i] <- wd_zh[[4]][i]
  }
}
wd_zh <- wd_zh %>%
  select(V9, V17) %>%
  rename(lunar_zh = V9, week_zh = V17)

# 英文空白合并以及合并后处理
for (i in seq_along(wd_en[[1]])) {
  if (wd_en[[1]][i] == "") {
    if (wd_en[[2]][i] != "") {
      wd_en[[1]][i] <- wd_en[[2]][i]
    } else {
      wd_en[[1]][i] <- wd_en[[3]][i]
    }
  } else {
    wd_en[[1]][i] <- wd_en[[1]][i]
  }
}
wd_en <- wd_en %>%
  select(V9) %>%
  rename(lunar_en = V9)

tbl <- cbind(year, wd_en, wd_zh)


# 2 -----------------------------------------------------------------------

require(readxl)
g_sum <- read_xlsx("./Excel/hoasgrade.xlsx", 1, "A8:J85") %>%
  dplyr::filter(成绩 >= 0)

g <- g_sum %>%
  dplyr::filter(学年 == 2017 | 学年 == 2016 | 学年 == 2018)

# g1 <- g_sum%>%
#   dplyr::filter(学年==2017&学期=="下")

"绩点" <- vector("double", 0.0)
attach(g)
for (i in seq_along(成绩)) {
  if (成绩[i] >= 90) {
    `绩点`[i] <- 4.0
  } else if (all(85 <= 成绩[i], 成绩[i] < 90)) {
    `绩点`[i] <- 3.7
  } else if (all(82 <= 成绩[i], 成绩[i] < 85)) {
    `绩点`[i] <- 3.3
  } else if (all(78 <= 成绩[i], 成绩[i] < 82)) {
    `绩点`[i] <- 3.0
  } else if (all(75 <= 成绩[i], 成绩[i] < 78)) {
    `绩点`[i] <- 2.7
  } else if (all(72 <= 成绩[i], 成绩[i] < 75)) {
    `绩点`[i] <- 2.3
  } else if (all(68 <= 成绩[i], 成绩[i] < 72)) {
    `绩点`[i] <- 2.0
  } else if (all(64 <= 成绩[i], 成绩[i] < 68)) {
    `绩点`[i] <- 1.5
  } else if (all(60 <= 成绩[i], 成绩[i] < 64)) {
    `绩点`[i] <- 1.0
  } else {
    `绩点`[i] <- 0
  }
}
g <- mutate(g, `绩点`)
detach(g)

g %>%
  dplyr::filter(课程类型 %in% c("专业必修", "公共必修", "专业选修")) %>%
  with({
    b1 <<- sum(学分 * 成绩) / sum(学分)
    sp1 <<- sum(学分 * 绩点) / sum(学分)
  })

gy <- g %>%
  group_by(课程类型) %>%
  summarise(
    数量 = n(),
    平均成绩 = mean(成绩, na.rm = TRUE)
  )

p <- c(89, 84, 81, 77, 74, 71, 67, 63, 59)

kaj <- g %>%
  dplyr::filter(成绩 %in% p)

count(kaj)

unkaj <- g %>%
  dplyr::filter(成绩 %in% p) %>%
  dplyr::mutate(成绩 = 成绩 + 1) %>%
  select(-绩点)

"绩点" <- vector("double", 0.0)
attach(unkaj)
for (i in seq_along(成绩)) {
  if (成绩[i] >= 90) {
    `绩点`[i] <- 4.0
  } else if (all(85 <= 成绩[i], 成绩[i] < 90)) {
    `绩点`[i] <- 3.7
  } else if (all(82 <= 成绩[i], 成绩[i] < 85)) {
    `绩点`[i] <- 3.3
  } else if (all(78 <= 成绩[i], 成绩[i] < 82)) {
    `绩点`[i] <- 3.0
  } else if (all(75 <= 成绩[i], 成绩[i] < 78)) {
    `绩点`[i] <- 2.7
  } else if (all(72 <= 成绩[i], 成绩[i] < 75)) {
    `绩点`[i] <- 2.3
  } else if (all(68 <= 成绩[i], 成绩[i] < 72)) {
    `绩点`[i] <- 2.0
  } else if (all(64 <= 成绩[i], 成绩[i] < 68)) {
    `绩点`[i] <- 1.5
  } else if (all(60 <= 成绩[i], 成绩[i] < 64)) {
    `绩点`[i] <- 1.0
  } else {
    `绩点`[i] <- 0
  }
}
unkaj <- mutate(unkaj, `绩点`)
detach(unkaj)

newg <- g %>%
  dplyr::filter(!(成绩 %in% p)) %>%
  rbind(unkaj) %>%
  dplyr::filter(课程类型 %in% c("专业必修", "公共必修", "专业选修")) %>%
  within({
    b2 <<- sum(学分 * 成绩) / sum(学分)
    sp2 <<- sum(学分 * 绩点) / sum(学分)
  })

sp2 - sp1

cre <- g %>%
  dplyr::filter(课程类型 %in% c("专业必修", "公共必修", "专业选修")) %>%
  group_by(学年) %>%
  summarise(
    课程总数 = n(),
    学分总数 = sum(学分)
  )
sum(cre$学分总数)

future <- read_xlsx("./Excel/hoasgrade.xlsx", 1, "A8:J85") %>%
  dplyr::filter(is.na(成绩))

sum(future$学分)

(sum(future$学分) * 4.0 + sum(cre$学分总数) * sp1) / (sum(future$学分) + sum(cre$学分总数)) - sp1




# 3 -----------------------------------------------------------------------

# '权绩' <- vector("double",0.0)
# gradeb2 <- grade17%>%
#   dplyr::filter(?纬绩点? == "绩点选??"|学习绩点 == "绩点")%>%
#   within({
#     `权绩` <<- 学分*成绩
#       # # if ((length(绩点选??)+length(绩点))>=8)
#       # b2 <<- sum(学分*成绩*0.002)
#       # sp2 <<- sum(学分*绩点)/sum(学分)
#   })%>%
#   mutate(`权绩`)%>%
#   arrange(desc(权绩))%>%
#   within({
#     if (length(权绩)<=8) {
#       b2 <<- sum(学分*成绩*0.002)
#       sp2 <<- sum(学分*绩点)/sum(学分)
#     } else {
#       b2 <<- sum(权绩*0.002)
#       sp2 <<- sum(学分*绩点)/sum(学分)
#     }
#   })
#
# f2 <- b1+b2



# 4 -----------------------------------------------------------------------

ipl <- function(x,xmin,xmax,ymin,ymax){
  y <- (ymax-ymin)/(xmax-xmin)*(x-xmin)+ymin
  return(y)
}

data <- read.table("clipboard", sep="\t", header=F) %>%
  select(1,12)
data2 <- read.table("clipboard", sep="\t", header=F) %>%
  select(2)
tb <- cbind(data,data2) %>%
  rename(中水年 = V12, 枯水年 = V2, month = V1) %>%
  melt(id="month")
library(cowplot)
ggplot(tb,aes(x = month,y = value, color = variable)) +
  geom_line()+
  geom_point()+
  labs(x = "月份", y = expression(出力/万kW)) +
  background_grid("xy")+
  scale_x_continuous(breaks=seq(0, 12, 2))+
  theme(legend.justification=c(1,1), legend.position=c(1,1),legend.title=element_blank())

