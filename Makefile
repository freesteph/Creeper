EXEC=creeper
PACKAGES=--pkg gtk+-3.0 --pkg gee-1.0 --pkg libwnck-3.0
SOURCES=creeper-main.vala creeper-activity.vala creeper-activity-view.vala

all:
	valac $(PACKAGES) $(SOURCES) -o $(EXEC)