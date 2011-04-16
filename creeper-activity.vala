
class Creeper.Activity {

	public string name { get; private set; }
	public static ulong time;
	public float percentage { get; private set; default=0.5f; }

	public Activity (string n, ulong t) {
		percentage = (float)(t)/(float)time;
		name = n;
		debug (@"Percentage = $percentage");
	}
}