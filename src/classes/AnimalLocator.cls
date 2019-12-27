/**
 * Created by solol on 24.12.2019.
 */

public with sharing class AnimalLocator {

    public static String getAnimalNameById(Integer id){
        String animal;
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + id);
        request.setMethod('GET');
        Http http = new Http();
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200){
            Map<String, Object> animalInfo = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            animal = (String) ((Map<String, Object>) animalInfo.get('animal')).get('name');
        }
        return animal;
    }
}