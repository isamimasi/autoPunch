from selenium import webdriver
import datetime
import time
companyName="*****" #企業ＩＤ
loginName="*****" #ユーザーＩＤ
passWord="******" #パスワード
punchIn="9:00"
punchOut="18:00"
def timeManagement():
    print ("start!!")
    checker=True
    while checker:
        dt_now = datetime.datetime.now()
        if punchIn=="{}:{}".format(dt_now.hour,dt_now.minute) and checker:
            print ("OK")
            #↓パンチインした後に止めるなら、有効にしてください。
            #checker=False
            login("punchin")
            time.sleep(120)
        if punchOut=="{}:{}".format(dt_now.hour,dt_now.minute) and checker:
            print ("OK")
            #↓パンチアウトした後に止めるなら、有効にしてください。
            #checker=False
            login("punchout")
            time.sleep(120)
    return
def login(punch):
    #chromedirverのPATH通していれば、わざわざパス指定不要
    #https://chromedriver.chromium.org/downloads からダウンロードし、このスクリプトのあるフォルダーにいれておきます
    driver = webdriver.Chrome(executable_path='chromedriver.exe')
    #出勤システムトップページにアクセス
    driver.get('https://www.lacras-io.jp/')
    #ユーザーid入力
    user_id_box =driver.find_element_by_name('loginCompany')
    user_id_box.send_keys(companyName)
    user_id_box = driver.find_element_by_name("LoginName")
    user_id_box.send_keys(loginName)
    #パスワード入力
    pass_box = driver.find_element_by_name("Passwd")
    pass_box.send_keys(passWord)
    #ログインをクリックする
    pass_box = driver.find_element_by_id("Login")
    pass_box.click()
    #button_click("ログイン")
    driver.get('https://www2.lacras-io.jp/working/result/NawWResultInput.jsp')
    if punch=="punchout":
        pass_box = driver.find_element_by_id("a_checkout")
        pass_box.click()
        print ("Punch Out")
    if punch=="punchin":
        pass_box = driver.find_element_by_id("a_gotowork")
        pass_box.click()
        print ("Punch In")
    return
timeManagement()
