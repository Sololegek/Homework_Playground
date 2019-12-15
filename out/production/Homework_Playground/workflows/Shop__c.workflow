<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Informing_that_new_shop_had_been_opened</fullName>
        <ccEmails>mozg_sololeg@mail.ru</ccEmails>
        <description>Informing that new shop had been opened</description>
        <protected>false</protected>
        <recipients>
            <recipient>sol.olegek@brave-otter-ykdwy.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opened_Shop_Email_Template</template>
    </alerts>
    <rules>
        <fullName>Opened_Shop_Email_Rule</fullName>
        <actions>
            <name>Informing_that_new_shop_had_been_opened</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
