
class Creeper.ActivitiesTree {

	private Gtk.TreeView tree;
	private Gtk.TreeViewColumn name;
	private Gtk.CellRendererText render_app;
	private Gtk.CellRendererProgress render_progress;
	private Gtk.CellAreaBox cell_area;

	public ActivitiesTree (Gtk.Builder builder) {
		tree = builder.get_object ("treeview1") as Gtk.TreeView;
		name = builder.get_object ("name") as Gtk.TreeViewColumn;
		render_app = builder.get_object ("render-name") as Gtk.CellRendererText;
		render_progress = builder.get_object ("render-progress") as Gtk.CellRendererProgress;

		cell_area = name.get_area () as Gtk.CellAreaBox;
		cell_area.orientation = Gtk.Orientation.VERTICAL;
	}
}