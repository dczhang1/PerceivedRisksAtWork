# Import Raw Data------------------------------------------
            df_pilot_ss23 <- read_csv("Data/df_raw_pilot.csv")


# Clean and Wrangling -------------------------------------
            ### Attention Check
            df_pilot_ss23_wide <- df_pilot_ss23 %>%
                        filter(ATTENTION == 5) %>%
            ### New variables
                        mutate(subj_id = row_number()) %>% # Subject ID
                        mutate(power_dif = POWER_2 - POWER_1) %>% # difference between current aspirational power vs. current power
                        mutate(power_loss = POWER_3 - POWER_1) # difference between past power vs. current power
            
# Sub-setting Data ----------------------------------------
            
            ### Wide to long for ML Analysis
            
            # Creating DV list
            dvlist <- list(c(40, 43, 46, 49, 52, 55, 58, 61, 64, 67), #affec
                           c(41, 44, 47, 50, 53, 56, 59, 62, 65, 68), #risk
                           c(42, 45, 48, 51, 54, 57, 60, 63, 66, 69), #bene
                           c(70, 71, 72, 73, 74, 75, 77, 78, 79, 80) #inten
            )
            # Name the DV list with variables
            names(dvlist) <- c("AFFECT",
                               "COST",
                               "BENEFIT",
                               "INTENT")
            
            # Long to wide using dvlist as index
            df_pilot_ss23_long <- mult.make.univ(
                        x=df_pilot_ss23_wide,
                        dvlist=dvlist)
            
# New Variables--------------------------------------------
            #group mean
            df_pilot_ss23_long$center_cost <- df_pilot_ss23_long$COST - ave(df_pilot_ss23_long$COST,df_pilot_ss23_long$subj_id)
            df_pilot_ss23_long$center_affect <- df_pilot_ss23_long$AFFECT - ave(df_pilot_ss23_long$AFFECT,df_pilot_ss23_long$subj_id)
            df_pilot_ss23_long$center_benefit <- df_pilot_ss23_long$BENEFIT - ave(df_pilot_ss23_long$BENEFIT,df_pilot_ss23_long$subj_id)
            df_pilot_ss23_long$center_intent <- df_pilot_ss23_long$INTENT - ave(df_pilot_ss23_long$INTENT,df_pilot_ss23_long$subj_id)
            
            #grand mean
            df_pilot_ss23_long$gmean_GRQ <- df_pilot_ss23_long$GRQ - mean(df_pilot_ss23_long$GRQ)
            
            