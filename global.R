library(shiny)
library(tidyverse)
library(shinydashboard)
library(readxl)
library(dplyr)
library(ggplot2)
library(plotly)
library(treemapify)
library(extrafont)
library(maps)
require(scales)
library(colorspace)
library(ggiraph)

acs_data_tn <- read.csv("data/demographics/acs_data_tn_geo.csv")

acs_data_tn_np <- read.csv("data/demographics/acs_data_tn_np.csv")

county_pres_returns <- read.csv("data/county_pres_returns/county_pres_returns_shiny.csv")

head(county_pres_returns)

map_choices <- c("Demographics","Presidential Vote")

county_choices <- c("Anderson","Bedford","Benton","Bledsoe","Blount",
                    "Bradley","Campbell","Cannon","Carroll","Carter",
                    "Cheatham","Chester","Claiborne","Clay","Cocke",
                    "Coffee","Crockett","Cumberland","Davidson","DeKalb",
                    "Decatur","Dickson","Dyer","Fayette","Fentress",
                    "Franklin","Gibson","Giles","Grainger","Greene",
                    "Grundy","Hamblen","Hamilton","Hancock","Hardeman",
                    "Hardin","Hawkins","Haywood","Henderson","Henry",
                    "Hickman","Houston","Humphreys","Jackson","Jefferson",
                    "Johnson","Knox","Lake","Lauderdale","Lawrence",
                    "Lewis","Lincoln","Loudon","Macon","Madison",
                    "Marion","Marshall","Maury","McMinn","McNairy",
                    "Meigs","Monroe","Montgomery","Moore","Morgan",
                    "Obion","Overton","Perry","Pickett","Polk",
                    "Putnam","Rhea","Roane","Robertson","Rutherford",
                    "Scott","Sequatchie","Sevier","Shelby","Smith",
                    "Stewart","Sullivan","Sumner","Tipton","Trousdale",
                    "Unicoi","Union","Van ","uren","Warren",
                    "Washington","Wayne","Weakley","White","Williamson",
                    "Wilson")

#transform(acs_data_tn, year = as.numeric(year))

ditch_the_axes <- theme(
  axis.text = element_blank(),
  axis.line = element_blank(),
  axis.ticks = element_blank(),
  panel.border = element_blank(),
  panel.grid = element_blank(),
  axis.title = element_blank())

states <- map_data("state")
tn<-subset(states, region %in% c("tennessee"))
tn_df<-subset(states, region=="tennessee")
counties<-map_data("county")
tn_county<-subset(counties, region=="tennessee")
tn_base <- ggplot(data = tn_df, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "black", fill = "gray")
tn_base +  
  geom_polygon(data = tn_county, fill = NA, color = "white") +
  geom_polygon(color = "black", fill = NA)
