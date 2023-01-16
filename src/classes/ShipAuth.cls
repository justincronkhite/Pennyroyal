/**
 * Created by justi on 1/9/2023.
 */

public with sharing class ShipAuth {
   
    public static String run() {
        String endpoint = 'https://login.salesforce.com/services/oauth2/token';
        String username = 'josh@ship4cheap.com';
        String password = 'hMJQPRY5O84AvUaqEhGlKjaDiBNLlFSub0zZ';
        String CONSUMER_KEY = '3MVG9ux34Ig8G5erv9VTKR_t22l9UksPb9tYA7wyEjydYvrnL84vU0_ILQgzVnT6jQaC0xGOfXL2z1f_yRjov';
        String CONSUMER_SECRET = '0EA8DAA7B814D491BFC1F1012250F4C95444C9B6D1EEC07FAEE8AC833E756ED1';

        HttpRequest ship = new HttpRequest();
        ship.setMethod('POST');
        ship.setHeader('Content-Type','application/x-www-form-urlencoded');

        ship.setBody(
                'grant_type=password' +
                        '&client_id=' + CONSUMER_KEY +
                        '&client_secret=' + CONSUMER_SECRET +
                        '&username=' + username +
                        '&password=' + password);
        ship.setEndpoint(endpoint);

        Http http = new Http();
        HttpResponse response;
                String accessToken;

        try {
            response = http.send(ship);
            System.debug('body: ' + response.getBody());
            accessToken = parseResponseForAccessToken(response.getBody());
        }catch(System.CalloutException error){
            System.debug('error: ' + error);
        }
        System.debug('access token: ' + accessToken);
        System.debug(UserInfo.getOrganizationId().substring(0, 15) + ' ' +  UserInfo.getSessionId().substring(15));
        return accessToken;
    }
    private static String parseResponseForAccessToken(String responseBody) {
        String accessToken;

        JSONParser parser = JSON.createParser(responseBody);
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'access_token')) {
                parser.nextToken();
                accessToken = parser.getText();
            }
        }
        return accessToken;
    }
}