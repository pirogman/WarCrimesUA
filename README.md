# WarCrimesUA

**Online round** task of iOS Dev Challenge XIX on 03.10.2022

![dev_challange_xix](https://user-images.githubusercontent.com/11997085/230085875-66c473e4-d47a-43d9-bb28-7ab86fa5f074.png)

## Task Description

Developing an iPad (Swift) application that is going to visualize crimes in Ukraine using the provided database, your task is to create a map visualization of the points along with general statistics of the crimes that happened (e.g. number of distinct crimes, total crimes). This project’s idea is to spread the news to the rest of the world about unjustified aggression against the Ukrainian nation.

## Requirements

- project should build on Xcode 14.0+. 
- language should be Swift.
- target should support the iPad as the main platform.
- minimal iOS version is 15.0.

## Screenshots

<img src="https://user-images.githubusercontent.com/11997085/230079910-4e698171-2c88-46c7-819c-b777c7903fad.png" width=400> <img src="https://user-images.githubusercontent.com/11997085/230079974-8d1d1c4e-102d-44ce-a031-b1a76762357e.png" width=400>

## Technologies

- UI build with SwiftUI
- MVVM Architecture
- MapKit

## Key Features

- Local database with more than 10,000 war crimes
- Cluster aggregation on the map with zoom to specific places
- Localised data: EN or UA
- Time period filter

## Challenges

- Choosing Swift UI led to some limitations for working with native maps (**MapKit**), mainly - point aggregation. This *required* task was done by grouping events into clustes and then displaying those clusters (event if a single event) on the map. The algorithm needs improvements though :D

- Another concern is lagging (freezing UI) when changing selected time period or language. Panning and zooming the map also has problems when there are many events to process. This could be improved by moving heavy computations off main queue, more sophisticated logic of when to reassemble clusters or even initial breakdown of events in days/sectors on the map.
