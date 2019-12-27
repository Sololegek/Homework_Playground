/**
 * Created by solol on 25.12.2019.
 */

@IsTest
private class ParkLocatorTest {
    @IsTest
    static void testBehavior() {
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        List<String> parks = ParkLocator.country('Germany');
        System.assertEquals(2, parks.size());
    }
}