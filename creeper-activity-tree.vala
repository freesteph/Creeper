
class Creeper.ActivitiesTree {

	private Gtk.TreeView tree;

	private Gtk.TreeViewColumn app_name;
	private Gtk.TreeViewColumn app_icon;
	private Gtk.TreeViewColumn app_time;

	public ActivitiesTree (Gtk.Builder builder) {
		tree = builder.get_object ("treeview1") as Gtk.TreeView;
	}
}