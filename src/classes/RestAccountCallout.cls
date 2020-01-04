/**
 * Created by solol on 29.12.2019.
 */

public with sharing class RestAccountCallout {

    private static String token = '00D2w000000nDXl!ARQAQNZSAnIHAe7q_rLtOTFev_gzgYVRqhFp8VoDLsgNQvoebebcHqMe7MZ3hq13jRO77req8obLHIFMNPlb2A_6QrAq2Obz';

    public static HttpResponse makeGetCallout(Id recordId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('https://brave-otter-ykdwy-dev-ed.my.salesforce.com/services/apexrest/Accounts/' + recordId);
        request.setHeader('Authorization','Bearer '+ token);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200){
            System.debug(response.getBody());
        }
        else{
            System.debug('Error ' + response.getStatusCode());
        }
        return response;
    }

    public static HttpResponse makePostCallout(String name){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('https://brave-otter-ykdwy-dev-ed.my.salesforce.com/services/apexrest/Accounts/');
        request.setHeader('Authorization','Bearer '+ token);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name" : "' + name + '"}');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200){
            System.debug(response.getBody());
        }
        else{
            System.debug('Error ' + response.getStatusCode());
        }
        return response;
    }

    public static HttpResponse makeDeleteCallout(Id recordId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('DELETE');
        request.setEndpoint('https://brave-otter-ykdwy-dev-ed.my.salesforce.com/services/apexrest/Accounts/' + recordId);
        request.setHeader('Authorization','Bearer '+ token);
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200){
            System.debug(response.getBody());
        }
        else{
            System.debug('Error ' + response.getStatusCode());
        }
        return response;
    }

    public static HttpResponse makePatchCallout(Id recordId, String name){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('https://brave-otter-ykdwy-dev-ed.my.salesforce.com/services/apexrest/Accounts/' + recordId + '?_HttpMethod=PATCH');
        request.setHeader('Authorization','Bearer '+ token);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name" : "' + name + '"}');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200){
            System.debug(response.getBody());
        }
        else{
            System.debug('Error ' + response.getStatusCode());
        }
        return response;
    }

    public static HttpResponse makePutCallout(Account account){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('PUT');
        request.setEndpoint('https://brave-otter-ykdwy-dev-ed.my.salesforce.com/services/apexrest/Accounts/');
        request.setHeader('Authorization','Bearer '+ token);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setBody('{"name" : "' + account.Name + '", "id" : "' + account.Id + '"}');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200){
            System.debug(response.getBody());
        }
        else{
            System.debug('Error ' + response.getStatusCode());
        }
        return response;
    }
}