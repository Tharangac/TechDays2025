namespace BCTechDays.PuppyMgt.Common;

using System.Environment.Configuration;
using Microsoft.Finance.RoleCenters;

pageextension 50100 "BusinessManagerRoleCenter_TD" extends "Business Manager Role Center"
{
    actions
    {
        addlast(sections)
        {
            group(PuppyMgt_TD)
            {
                Caption = 'Puppy Management';

                action(CustomIntegrationSetup_TD)
                {
                    ApplicationArea = All;
                    Caption = 'Setup';
                    RunObject = page "PuppyMgtSetup_TD";
                }

                action(PuppyList_TD)
                {
                    ApplicationArea = All;
                    Caption = 'Puppies';
                    RunObject = page "PuppyList_TD";
                }
            }

            group(BusinessEvents_TD)
            {
                Caption = 'Business Events';

                action(BusinessEventSubscriptions_TD)
                {
                    ApplicationArea = All;
                    Caption = 'Business Event Subscriptions';
                    RunObject = page "EE Subscription List";
                }
                action(BusinessEventNotifications_TD)
                {
                    ApplicationArea = All;
                    Caption = 'Business Event Notifications';
                    RunObject = page "EE Notification List";
                }
                action(BusinessEventLog_TD)
                {
                    ApplicationArea = All;
                    Caption = 'Business Event Log';
                    RunObject = page "EE Activity Logs";
                }
            }
        }
    }
}