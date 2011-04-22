
class Creeper.ActivitiesTree {

	private Gtk.TreeView tree;
	private Gtk.TreeViewColumn name;
	private Gtk.CellRendererText render_app;
	private Gtk.CellRendererProgress render_progress;
	private Gtk.CellArea cell_area;

	public ActivitiesTree (Gtk.Builder builder) {
		tree = builder.get_object ("treeview1") as Gtk.TreeView;
		name = builder.get_object ("name") as Gtk.TreeViewColumn;
		render_app = builder.get_object ("render-name") as Gtk.CellRendererText;
		render_progress = builder.get_object ("render-progress") as Gtk.CellRendererProgress;

		cell_area = name.get_area ();
		var box = new Gtk.CellAreaBox ();
		box.orientation = Gtk.Orientation.VERTICAL;
		box.pack_start (render_app, false);
		box.pack_start (render_progress, false);
		cell_area = box;
	}
}