
;;;======================================================
;;;   Which Shakespeare Play Should You See First
;;;
;;;   Tobiasz Gruszczyñski 145333
;;;   Sebastian Grabowski 145248
;;;
;;;======================================================

;;; ***************************
;;; * DEFTEMPLATES & DEFFACTS *
;;; ***************************

(deftemplate UI-state
   (slot id (default-dynamic (gensym*)))
   (slot display)
   (slot relation-asserted (default none))
   (slot response (default none))
   (multislot valid-answers)
   (slot state (default middle)))
   
(deftemplate state-list
   (slot current)
   (multislot sequence))
  
(deffacts startup
   (state-list))
   
;;;****************
;;;* STARTUP RULE *
;;;****************

(defrule system-banner ""

  =>
  
  (assert (UI-state (display WelcomeMessage)
                    (relation-asserted start)
                    (state initial)
                    (valid-answers))))

;;;***************
;;;* QUESTIONS RULES *
;;;***************

(defrule begin ""

   (logical (start))

   =>

   (assert (UI-state (display StartQuestion)
                     (relation-asserted what-do-you-want)
                     (response Take_a_nap)
                     (valid-answers Take_a_nap Laugh Cry Watch All_of_the_above NoneOfAbove))))
                     
(defrule None-next ""

   (logical (what-do-you-want NoneOfAbove))

   =>

   (assert (UI-state (display SoWhatYouDoYouWant)
                     (relation-asserted nonall)
                     (response NiceStoryWithShip)
                     (valid-answers NiceStoryWithShip Kinsmen))))

(defrule Watch-next ""

   (logical (what-do-you-want Watch))

   =>

   (assert (UI-state (display EnglishHistory)
                     (relation-asserted english)
                     (response IPreferClassics)
                     (valid-answers IPreferClassics ItReallyAwesome DunnoAwesome))))

(defrule Really-next ""

   (or
   (logical (english ItReallyAwesome))
   (logical (dunno))
   )
   =>

   (assert (UI-state (display ExcommunicationQuestion)
                     (relation-asserted excomm)
                     (response WowIsItEver)
                     (valid-answers WowIsItEver Boooring))))
                     
(defrule Dunno-next ""

   (logical (english DunnoAwesome))

   =>

   (assert (UI-state (display NoItReallyAwesome)
                     (relation-asserted dunno))))
                     
(defrule Boring-next ""

   (logical (excomm Boooring))

   =>

   (assert (UI-state (display HowMuchTimeQuestion)
                     (relation-asserted time)
                     (response JustaFewHours)
                     (valid-answers JustaFewHours ImHereAllWeek))))
                     
(defrule Few-next ""

   (logical (time JustaFewHours))

   =>

   (assert (UI-state (display GoodGuysBadBoysQuestion)
                     (relation-asserted boys)
                     (response GoodGuys)
                     (valid-answers GoodGuys BadBoys))))   
                     
(defrule Week-next ""

   (logical (time ImHereAllWeek))

   =>

   (assert (UI-state (display WhichDoYouPreferQuestion)
                     (relation-asserted prefer)
                     (response ComingOfAge)
                     (valid-answers ComingOfAge LotsBattles))))                                                                  
                     
(defrule Laugh-next ""

   (logical (what-do-you-want Laugh))

   =>

   (assert (UI-state (display MurderQuestion)
                     (relation-asserted murder)
                     (response Disturbing)
                     (valid-answers Disturbing Hilarious))))

(defrule Cry-next ""

   (logical (what-do-you-want Cry))

   =>

   (assert (UI-state (display OpinionRevengeQuestion)
                     (relation-asserted opinion)
                     (response BestRevange)
                     (valid-answers BestRevange PointlessRevange))))

(defrule Best-next ""

   (logical (opinion BestRevange))

   =>

   (assert (UI-state (display DeathTollsQuestion)
                     (relation-asserted tolls)
                     (response HighTolls)
                     (valid-answers HighTolls ModerateTolls LowTolls))))

(defrule Pointless-next ""

   (logical (opinion PointlessRevange))

   =>

   (assert (UI-state (display MostImportantQuestion)
                     (relation-asserted important)
                     (response Love2)
                     (valid-answers Love2 Family Power))))

(defrule Love-next ""

   (logical (important Love2))

   =>

   (assert (UI-state (display TypeLoveQuestion)
                     (relation-asserted loves)
                     (response ImmatureLove)
                     (valid-answers ImmatureLove MatureLove JealousObsession))))
                                                              
(defrule Family-next ""

   (logical (important Family))

   =>

   (assert (UI-state (display PickParentQuestion)
                     (relation-asserted parent)
                     (response Mum)
                     (valid-answers Mum Dad))))
                                                              
(defrule Power-next ""

   (logical (important Power))

   =>

   (assert (UI-state (display WorkBestWithQuestion)
                     (relation-asserted work)
                     (response Friends)
                     (valid-answers Friends SignificantOther Everyone))))


(defrule Disturbing-next ""

   (logical (murder Disturbing))

   =>

   (assert (UI-state (display Cross-dressingQuestion)
                     (relation-asserted cross-dressing)
                     (response Yea)
                     (valid-answers Yea Nay))))
                     
(defrule Yea-next ""

   (logical (cross-dressing Yea))

   =>

   (assert (UI-state (display TwinsQuestion)
                     (relation-asserted twins)
                     (response NoTwins)
                     (valid-answers NoTwins TwinsAwesome))))
                     
(defrule No-twins-next ""

   (logical (twins NoTwins))

   =>

   (assert (UI-state (display ForestQuestion)
                     (relation-asserted forest)
                     (response ForestYes)
                     (valid-answers ForestYes ForestNo))))

(defrule Forest-yes-next ""

   (logical (forest ForestYes))

   =>

   (assert (UI-state (display ForestQuestion2)
                     (relation-asserted forest)
                     (response Shepherds)
                     (valid-answers Shepherds Bandits))))

(defrule Nay-next ""

   (logical (cross-dressing Nay))

   =>

   (assert (UI-state (display TwinsQuestion2)
                     (relation-asserted twins)
                     (response TwinsContrived)
                     (valid-answers TwinsContrived TwinsFun))))

(defrule Contrived-next ""

   (logical (twins TwinsContrived))

   =>

   (assert (UI-state (display PickyQuestion)
                     (relation-asserted magic)
                     (response MagicLove)
                     (valid-answers MagicLove MagicNo))))

(defrule MagicLove-next ""

   (logical (magic MagicLove))

   =>

   (assert (UI-state (display MagicQuestion)
                     (relation-asserted magic)
                     (response Illusion)
                     (valid-answers Illusion Fairies Miracles))))

(defrule MagicNo-next ""

   (logical (magic MagicNo))

   =>

   (assert (UI-state (display CrowdQuestion)
                     (relation-asserted crowd)
                     (response Over-educated)
                     (valid-answers Over-educated Quarrelsome Reluctant Married))))

(defrule Quarrelsome-next ""

   (logical (crowd Quarrelsome))

   =>

   (assert (UI-state (display ViolentlyQuestion)
                     (relation-asserted violently)
                     (response Argumentative)
                     (valid-answers Argumentative BringIt))))

(defrule Reluctant-next ""

   (logical (crowd Reluctant))

   =>

   (assert (UI-state (display InvolvedQuestoin)
                     (relation-asserted involved)
                     (response Maybe)
                     (valid-answers Maybe NoInvolved))))                     
;;;****************
;;;* FINAL RULES *
;;;****************
   
(defrule do-henry8 ""

   (logical (what-do-you-want Take_a_nap))

   =>

   (assert (UI-state (display Henry_8)
                     (state final))))
                     
(defrule do-cymbeline ""
   
   (logical (what-do-you-want All_of_the_above))
   
   =>

   (assert (UI-state (display Cymbeline)
                     (state final))))
                     
(defrule do-laugh ""
   
   (logical (what-do-you-want Laugh))
   
   =>

   (assert (UI-state (display Laugh)
                     )))
                     
(defrule do-hilarious ""
   (or
   (logical (tolls HighTolls))
   (logical (murder Hilarious))
   )
   =>

   (assert (UI-state (display Titus)
                     (state final))))

(defrule do-hamlet ""
   
   (logical (tolls ModerateTolls))
   
   =>

   (assert (UI-state (display Hamlet)
                     (state final))))

(defrule do-timon ""
   
   (logical (tolls LowTolls))
   
   =>

   (assert (UI-state (display TimonOfAthens)
                     (state final))))
                     
(defrule do-twins-awesome ""
   
   (logical (twins TwinsAwesome))
   
   =>

   (assert (UI-state (display TwelfthNight)
                     (state final))))
                     
(defrule do-forest-no ""
   
   (logical (forest ForestNo))
   
   =>

   (assert (UI-state (display Merchant)
                     (state final))))

(defrule do-shepherds ""
   
   (logical (forest Shepherds))
   
   =>

   (assert (UI-state (display AsYouLike)
                     (state final))))

(defrule do-bandits ""
   
   (logical (forest Bandits))
   
   =>

   (assert (UI-state (display TwoGentlemen)
                     (state final))))

(defrule do-twins-fun ""
   
   (logical (twins TwinsFun))
   
   =>

   (assert (UI-state (display TwinsComedy)
                     (state final))))

(defrule do-illusion ""
   
   (logical (magic Illusion))
   
   =>

   (assert (UI-state (display Tempest)
                     (state final))))

(defrule do-fairies ""
   
   (logical (magic Fairies))
   
   =>

   (assert (UI-state (display Midsummer)
                     (state final))))

(defrule do-miracles ""
   
   (logical (magic Miracles))
   
   =>

   (assert (UI-state (display Winter)
                     (state final))))

(defrule do-over-educated ""
   
   (logical (crowd Over-educated))
   
   =>

   (assert (UI-state (display Love)
                     (state final))))

(defrule do-married ""
   
   (logical (crowd Married))
   
   =>

   (assert (UI-state (display Marry)
                     (state final))))

(defrule do-argumentative ""
   
   (logical (violently Argumentative))
   
   =>

   (assert (UI-state (display Nothing)
                     (state final))))

(defrule do-bring-it ""
   
   (logical (violently BringIt))
   
   =>

   (assert (UI-state (display Taming)
                     (state final))))

(defrule do-maybe ""
   
   (logical (involved Maybe))
   
   =>

   (assert (UI-state (display Measure)
                     (state final))))

(defrule do-no-involved ""
   
   (logical (involved NoInvolved))
   
   =>

   (assert (UI-state (display AllWell)
                     (state final))))

(defrule do-romeo ""
   
   (logical (loves ImmatureLove))
   
   =>

   (assert (UI-state (display RomeoJuliet)
                     (state final))))

(defrule do-antony ""
   
   (logical (loves MatureLove))
   
   =>

   (assert (UI-state (display AntonyCleopatra)
                     (state final))))
                     
(defrule do-othello ""
   
   (logical (loves JealousObsession))
   
   =>

   (assert (UI-state (display Othello)
                     (state final))))
                     
(defrule do-coriolanus ""
   
   (logical (parent Mum))
   
   =>

   (assert (UI-state (display Coriolanus)
                     (state final))))
                     
(defrule do-king-lear ""
   
   (logical (parent Dad))
   
   =>

   (assert (UI-state (display KingLear)
                     (state final))))         

(defrule do-cesar ""
   
   (logical (work Friends))
   
   =>

   (assert (UI-state (display Julius)
                     (state final))))  
                     
(defrule do-macbeth ""
   
   (logical (work SignificantOther))
   
   =>

   (assert (UI-state (display Macbeth)
                     (state final))))  
                     
(defrule do-richard2 ""
   
   (logical (work Everyone))
   
   =>

   (assert (UI-state (display Richard2)
                     (state final))))                                                     
           
(defrule do-troilus ""
   
   (logical (english IPreferClassics))
   
   =>

   (assert (UI-state (display TroilusAndCressida)
                     (state final))))            
         
(defrule do-king-john ""
   
   (logical (excomm WowIsItEver))
   
   =>

   (assert (UI-state (display KingJohn)
                     (state final))))           
         
(defrule do-richard3 ""
   
   (logical (boys BadBoys))
   
   =>

   (assert (UI-state (display Richard3)
                     (state final))))            
         
(defrule do-henry5 ""
   
   (logical (boys GoodGuys))
   
   =>

   (assert (UI-state (display Henry5)
                     (state final))))            
         
(defrule do-henry4 ""
   
   (logical (prefer ComingOfAge))
   
   =>

   (assert (UI-state (display Henry4)
                     (state final))))   
                     
(defrule do-henry6 ""
   
   (logical (prefer LotsBattles ))
   
   =>

   (assert (UI-state (display Henry6)
                     (state final))))   
                                
(defrule do-pericles ""
   
   (logical (nonall NiceStoryWithShip))
   
   =>

   (assert (UI-state (display Pericles)
                     (state final))))                            
                                
(defrule do-kinsmen ""
   
   (logical (nonall Kinsmen))
   
   =>

   (assert (UI-state (display TheTwoNobleKinsmen)
                     (state final))))                                 
                                
                                                              
;;;*************************
;;;* GUI INTERACTION RULES *
;;;*************************

(defrule ask-question

   (declare (salience 5))
   
   (UI-state (id ?id))
   
   ?f <- (state-list (sequence $?s&:(not (member$ ?id ?s))))
             
   =>
   
   (modify ?f (current ?id)
              (sequence ?id ?s))
   
   (halt))

(defrule handle-next-no-change-none-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
                      
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-response-none-end-of-chain

   (declare (salience 10))
   
   ?f <- (next ?id)

   (state-list (sequence ?id $?))
   
   (UI-state (id ?id)
             (relation-asserted ?relation))
                   
   =>
      
   (retract ?f)

   (assert (add-response ?id)))   

(defrule handle-next-no-change-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
     
   (UI-state (id ?id) (response ?response))
   
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-change-middle-of-chain

   (declare (salience 10))
   
   (next ?id ?response)

   ?f1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))
     
   (UI-state (id ?id) (response ~?response))
   
   ?f2 <- (UI-state (id ?nid))
   
   =>
         
   (modify ?f1 (sequence ?b ?id ?e))
   
   (retract ?f2))
   
(defrule handle-next-response-end-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)
   
   (state-list (sequence ?id $?))
   
   ?f2 <- (UI-state (id ?id)
                    (response ?expected)
                    (relation-asserted ?relation))
                
   =>
      
   (retract ?f1)

   (if (neq ?response ?expected)
      then
      (modify ?f2 (response ?response)))
      
   (assert (add-response ?id ?response)))   

(defrule handle-add-response

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id ?response)
                
   =>
      
   (str-assert (str-cat "(" ?relation " " ?response ")"))
   
   (retract ?f1))   

(defrule handle-add-response-none

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id)
                
   =>
      
   (str-assert (str-cat "(" ?relation ")"))
   
   (retract ?f1))   

(defrule handle-prev

   (declare (salience 10))
      
   ?f1 <- (prev ?id)
   
   ?f2 <- (state-list (sequence $?b ?id ?p $?e))
                
   =>
   
   (retract ?f1)
   
   (modify ?f2 (current ?p))
   
   (halt))
   
