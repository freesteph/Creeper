EXEC=creeper
PACKAGES=--pkg gtk+-3.0 --pkg gee-1.0 --pkg libwnck-3.0
SOURCES=creeper-main.vala creeper-activity.vala creeper-activity-tree.vala
FLAGS=-DWNCK_I_KNOW_THIS_IS_UNSTABLE
all:
	valac $(PACKAGES) -X $(FLAGS) $(SOURCES) -o $(EXEC)
