# Import Raw Data------------------------------------------
            df_pilot_ss23 <- read_csv("Data/df_raw_pilot.csv")


# Clean and Wrangling -------------------------------------
            ### Attention Check
            df_pilot_ss23_wide <- df_pilot_ss23 %>%
                        filter(ATTENTION == 5) %>%
                        mutate(subj_id = row_number())
            
            
            
# New Variables--------------------------------------------


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