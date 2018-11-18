1000 in=3 : out=4
1010 OPEN #in;'ram1_spread_file_BigTest_Psion'
1020 OPEN_OVER #out;'ram1_output'
1025 DIM col_sz%(64),psi_text$(1024,64),psi_form$(1024,64)
1027 form_cnt=0 : text_cnt=0
1030 :
1035 collect_text
1037 BGET #in\0
1038 form_cnt=0 : text_cnt=0
1040 IF get_val$=='TAB0'
1050    g_format$=get_val$
1060    max_size$=get_val$
1070    nr_cols='0'&get_val$
1080    FOR i=1 TO nr_cols : col_sz%(i)=('0'&get_val$)-1 : PRINT col_sz%(i),
1085    PRINT
1090    dummy$=get_val$
1100    used_size$=get_val$
1130    col%=0
1140    row%=0
1150    nr_rows='0'&get_val$
1160    FOR x=1 TO nr_rows
1170       row_info$=get_val$
1180       nr_values=tuple$(row_info$,2)
1190       FOR i=1 TO nr_values
1200          psion_fmt$=get_val$
1207          psion_val$=get_val$
1211          IF psion_fmt$(2) INSTR 'FG' THEN dummy$=get_val$
1213          IF psion_fmt$(2)=="S" THEN psion_val$=psi_text$(text_cnt) : text_cnt=text_cnt+1
1214          IF psion_fmt$(2)=="F" THEN psion_val$=psi_form$(text_cnt) : text_cnt=text_cnt+1
1215          PRINT #out;psion_fmt$;' = ';psion_val$
1220       END FOR i
1230    END FOR x
1300 END IF 
1310 CLOSE
3000 DEFine PROCedure collect_text
3010 IF get_val$=='TAB0'
3020    dummy$=get_val$
3030    dummy$=get_val$
3040    dummy$=get_val$
3050    FOR i=1 TO nr_cols : dummy$=get_val$
3060    dummy$=get_val$
3070    dummy$=get_val$
3080    nr_rows='0'&get_val$
3090    FOR x=1 TO nr_rows
3100       row_info$=get_val$
3110       nr_values=tuple$(row_info$,2)
3120       FOR i=1 TO nr_values
3130          psion_fmt$=get_val$
3140          psion_val$=get_val$
3150          IF psion_fmt$(2) INSTR 'FG' THEN dummy$=get_val$
3160       END FOR i
3170    END FOR x
3180    nr_texts='0'&get_val$
3190    FOR x=1 TO nr_texts
3200       psion_inf$=get_val$
3205       IF psion_inf$(1)=="T" THEN 
3210          psion_con$=get_txt$
3215       ELSE 
3217          psion_con$=get_form$
3218       END IF 
3230       nr_entries=tuple$(psion_inf$(2 TO LEN(psion_inf$)),1)
3240       FOR e=1 TO nr_entries
3250          IF psion_inf$(1)=="T" THEN 
3260             psi_text$(text_cnt)=psion_con$
3270             text_cnt=text_cnt+1
3280          END IF 
3290          IF psion_inf$(1)=="F" THEN 
3300             psi_form$(form_cnt)=psion_con$
3310             form_cnt=form_cnt+1
3320          END IF 
3330       END FOR e
3340    END FOR x
3350 END IF 
3360 END DEFine 
3370 :
4000 DEFine FuNction mget_val$(p)
4002   LOCal x,byte
4005   a$=""
4010   REPeat x
4020     IF EOF(#in) THEN EXIT x
4030     BGET #in;byte
4040     SELect ON byte
4050       =13 : EXIT x
4060       =(33-p) TO 191 : a$=a$&CHR$(byte)
4070     END SELect 
4080   END REPeat x
4090   RETurn a$
4100 END DEFine 
4110 :
4120 DEFine FuNction tuple$(x$,n)
4125    LOCal cnt,byte
4130    a$=""
4135    cnt=1
4140    FOR i=1 TO LEN(x$)
4150       byte=CODE(x$(i))
4160       SELect ON byte
4170          =44 : cnt=cnt+1
4180          =REMAINDER : IF cnt=n THEN a$=a$&CHR$(byte)
4190       END SELect 
4200       IF cnt>n THEN EXIT i
4210    END FOR i
4215    RETurn a$
4220 END DEFine 
4230 :
4240 DEFine FuNction get_val$
4250    RETurn mget_val$(0)
4260 END DEFine 
4270 :
4280 DEFine FuNction get_txt$
4290    RETurn mget_val$(1)
4300 END DEFine 
4310 :
4320 DEFine FuNction get_form$
4325    LOCal i
4330    a$=""
4340    REPeat i
4350       BGET #in,byte
4360       SELect ON byte
4370         =46 : EXIT i
4380         =REMAINDER : a$=a$&CHR$(byte)
4390       END SELect 
4400    END REPeat i
4410    BGET #in,byte
4420    RETurn a$
4430 END DEFine 
