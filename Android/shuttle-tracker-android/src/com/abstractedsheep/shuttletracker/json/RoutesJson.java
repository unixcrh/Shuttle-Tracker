package com.abstractedsheep.shuttletracker.json;

import java.util.ArrayList;

import com.abstractedsheep.shuttletracker.android.DirectionalOverlayItem;
import com.google.android.maps.GeoPoint;

public class RoutesJson {
	private ArrayList<Stop> stops;
	private ArrayList<Route> routes;
	
	public static class Stop {
		private double latitude;
		public double getLatitude() {
			return latitude;
		}

		public void setLatitude(double latitude) {
			this.latitude = latitude;
		}

		public double getLongitude() {
			return longitude;
		}

		public void setLongitude(double longitude) {
			this.longitude = longitude;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getShort_name() {
			return short_name;
		}

		public void setShort_name(String short_name) {
			this.short_name = short_name;
		}

		public ArrayList<Route> getRoutes() {
			return routes;
		}

		public void setRoutes(ArrayList<Route> routes) {
			this.routes = routes;
		}

		private double longitude;
		private String name;
		private String short_name;
		private ArrayList<Route> routes;
		
		public static class Route {
			private int id;
			public int getId() {
				return id;
			}
			public void setId(int id) {
				this.id = id;
			}
			public String getName() {
				return name;
			}
			public void setName(String name) {
				this.name = name;
			}
			private String name;
		}
		
		public DirectionalOverlayItem toOverlayItem() {	
			return new DirectionalOverlayItem(new GeoPoint((int) (this.latitude * 1e6), (int)(this.longitude * 1e6)), this.name, "");
		}
	}
	
	public static class Route {
		private String color;
		private int id;
		private String name;
		public String getColor() {
			return color;
		}

		public void setColor(String color) {
			this.color = color;
		}

		public int getId() {
			return id;
		}

		public void setId(int id) {
			this.id = id;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public int getWidth() {
			return width;
		}

		public void setWidth(int width) {
			this.width = width;
		}

		public ArrayList<Coord> getCoords() {
			return coords;
		}

		public void setCoords(ArrayList<Coord> coords) {
			this.coords = coords;
		}

		private int width;
		private ArrayList<Coord> coords;
		
		public static class Coord {
			private double latitude;
			public double getLatitude() {
				return latitude;
			}
			public void setLatitude(double latitude) {
				this.latitude = latitude;
			}
			public double getLongitude() {
				return longitude;
			}
			public void setLongitude(double longitude) {
				this.longitude = longitude;
			}
			private double longitude;
		}
	}

	public ArrayList<Stop> getStops() {
		return stops;
	}

	public void setStops(ArrayList<Stop> stops) {
		this.stops = stops;
	}

	public ArrayList<Route> getRoutes() {
		return routes;
	}

	public void setRoutes(ArrayList<Route> routes) {
		this.routes = routes;
	}
}
