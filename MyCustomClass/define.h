//
//  define.h
//  Patient
//
//  Created by Alok Singh on 4/26/16.
//  Copyright © 2016 mithun ravi. All rights reserved.
//

#import <Foundation/Foundation.h>
#define USERDEFAULTS                [NSUserDefaults standardUserDefaults]
#define SYNCHRONISE                 [[NSUserDefaults standardUserDefaults] synchronize]
#define GETVALUE(keyname)           [[NSUserDefaults standardUserDefaults] valueForKey:keyname]
#define SETVALUE(value,keyname)     [[NSUserDefaults standardUserDefaults] setValue:value forKey:keyname]
#define DELETEVALUE(keyname)        [[NSUserDefaults standardUserDefaults] removeObjectForKey:keyname]

/*session*/

#define FirstTime @"FirstTimeDataDump"
#define SyncDate @"LastSyncDate"




//SETVALUE([json valueForKey:@"id"], kUSERID);

//GETVALUE(kUSERID)
#define CURRENT_HEALTH_PROBLEM  @"current_health_problems"
#define PAST_HEALTH_PROBLEM  @"past_health_problems"
#define FAMILY_HEALTH_PROBLEM  @"family_health_problems"
#define BIRTH_CHILDHOOD_HEALTH_PROBLEM  @"birth_and_childhood_problems"
#define IMMUNIZATION_AND_ALLERGIES_HEALTH_PROBLEM  @"immunization_and_allergies"
#define BLOOD_PRESURE @"blood_pressure"
#define WEIGHT @"weight"
#define BLOOD_SUGAR @"blood_sugar"
#define URINE_SUGAR @"urine_sugar"


#define HISTORYTABLEVIEWCELL @"HistoryTableViewCell"
#define CELLIDENTIFIER @"defin"
#define TITLE @"Title"
#define START_CAUSE_PROBLEM @"Start & Cause of Problem"
#define DESCRIPTION_DETAIL @"Description in Detail"
#define WHAT_MAKES_BETTER_WORSE @"What Makes it Better or Worse"
#define TREATMENT_TAKEN_SO_FOR @"Treatement Taken So For"

#define VITALTABLEVC @"VitalTableViewController"
#define HISTORYVC @"MyHistoryViewController"
#define HISTORY_ID_STRING @"history_id"
#define HISTORY_DATE_STRING @"history_date"





#define NUMBER_OF_TYPE_HISTORY 1
#define NUMBER_ZERO 0
#define NUMBER_ONE 1
#define HISTORY_SECTION_HEIGHT 164
#define ATTACHEMENT_SECTION_NUMBER 7

