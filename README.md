# WarCrimesUS

## Technologies

- UI build with SwiftUI
- MVVM Architecture
- MapKit

## Challenges

- Choosing Swift UI led to some limitations for working with native maps (**MapKit**), mainly - point aggregation. This *required* task was done by grouping events into clustes and then displaying those clusters (event if a single event) on the map. The algorithm needs improvements though :D

- Another concern is lagging (freezing UI) when changing selected time period or language. Panning and zooming the map also has problems when there are many events to process. This could be improved by moving heavy computations off main queue, more sophisticated logic of when to reassemble clusters or even initial breakdown of events in days/sectors on the map.
