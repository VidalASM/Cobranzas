package com.zs.utils;

public class Types {

	public static final int COMITE_TYPE = 0;
	public static final int ORGANIZER_COORDINATOR_TYPE = 1;
	public static final int ORGANIZER_BOSS_TYPE = 2;
	public static final int ORGANIZER_WORKER_TYPE = 3;
	
	public static int TypeOrganizerMapping(String type){
		if(type.equals("Jefe")) return ORGANIZER_BOSS_TYPE;
		else if(type.equals("Trabajador")) return ORGANIZER_WORKER_TYPE;
		else if(type.equals("Coordinador General")) return ORGANIZER_COORDINATOR_TYPE;
		return -1;
	}
	
}
