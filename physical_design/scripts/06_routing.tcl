setNanoRouteMode -droutePostRouteViaOpt true
# Enable post-route via optimization to reduce via count and improve routing quality

routeDesign
# Run detailed routing (NanoRoute) for the full design

addFiller -cell {FILL1 FILL2 FILL4 FILL8 FILL16} -prefix FILL
# Insert physical filler cells into empty placement rows to maintain continuous N-well/diffusion