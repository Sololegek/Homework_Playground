/**
 * Created by solol on 25.12.2019.
 */

public with sharing class ParkLocator {

    public static List<String> country(String country){
        ParkService.ParksImplPort parksImplPort = new ParkService.ParksImplPort();
        return parksImplPort.byCountry(country);
    }
}