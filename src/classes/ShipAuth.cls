/**
 * Created by justi on 1/9/2023.
 */

Global with sharing class ShipAuth {
   @Future(callout=true)
   global static void run() {
       system.debug('Callout Started');
        Cache.OrgPartition orgPart = Cache.Org.getPartition('local.DefaultPartition');
        String accessToken = (String)orgPart.get('token');
        DateTime expires = (Datetime)orgPart.get('expires');
        String endpoint = 'https://login.salesforce.com/services/oauth2/token';
        String username = 'josh@ship4cheap.com';
        String password = 'RBpKaZC54x4HwbGL0SuJwVgJTjKcNXGlmEQZV';
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
        HttpResponse responseToken;
                //String accessToken;

        try {
            responseToken = http.send(ship);
            System.debug('body: ' + responseToken.getBody());
            if (responseToken.getStatusCode() == 200) {

                //Deserialize response and store it in map
                Map<String, Object> mapResultToken = (Map<String, Object>) JSON.deserializeUntyped(responseToken.getBody());

                //Storing Access Token and Expiry to Org cache
                orgPart.put('token',mapResultToken.get('access_token'));
                orgPart.put('expires',system.now().addSeconds(3600));
                system.debug('The AC is from ShipAuth'+mapResultToken.get('access_token'));
                system.debug('This is from AHipAuth Cache'+orgPart.get('token'));

            }
//            accessToken = parseResponseForAccessToken(response.getBody());
        }catch(System.CalloutException error){
            System.debug('error: ' + error);
        }
        //System.debug('access token: ' + accessToken);
        //System.debug('LAst debug from Ship auth'+UserInfo.getOrganizationId().substring(0, 15) + ' ' +  UserInfo.getSessionId().substring(15));
        //return accessToken;
    }
//    private static String parseResponseForAccessToken(String responseBody) {
//        String accessToken;
//
//        JSONParser parser = JSON.createParser(responseBody);
//        while (parser.nextToken() != null) {
//            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'access_token')) {
//                parser.nextToken();
//                accessToken = parser.getText();
//            }
//        }
//        return accessToken;
//    }
}