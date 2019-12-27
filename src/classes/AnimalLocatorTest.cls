/**
 * Created by solol on 25.12.2019.
 */

@IsTest
private class AnimalLocatorTest {
    @IsTest
    static void testBehavior() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());
        String animal = AnimalLocator.getAnimalNameById(2);
        System.assertEquals('bear', animal);
    }
}