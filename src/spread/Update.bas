1 OPEN#0,con_400x200a50x50:BORDER#0,1,4:CLS#0
50  COPY_O win1_spread_QSPREAD_ENGLISH,win1_exec_QSpread
60  COPY_O win1_spread_QSPREAD_ENGLISH,win1_m_qspr_QSPREAD_ENGLISH
70  COPY_O win1_spread_QSPREAD_GERMAN,win1_m_qspr_QSPREAD_GERMAN
90  EW menuconfig;'\u win1_exec_Qspread \q'
100  FORMAT ram8_
110  COPY win1_spread_QSPREAD_ENGLISH,ram8_QSPREAD_ENGLISH
115  COPY win1_spread_QSPREAD_GERMAN,ram8_QSPREAD_GERMAN
130  EW pack;win1_qbox_u_qspread_QSPREAD_zip
150  EXEP qd;'win1_m_files_qspr'
180 QUIT
