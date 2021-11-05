import os,sys,csv
import youtube_dl
import glob
import ffmpeg

from concurrent.futures import ThreadPoolExecutor

import subprocess
import time

from myYoutubedl import *
from myffmpeg import *

dprint=lambda x:print(x) 

MAXWAVES = 50
MAXPROCESS=8


DIR = os.path.dirname(os.path.abspath(__file__))
def main():
    argv=sys.argv
    if(len(argv) > 1):
        target = ReadInputfile(argv[1])
    else:
        target="target"
    target=os.path.join(DIR,target)
    print("target:",target)   
    
    labels=getLabels(target)
    
    for phase in ["eval","balanced_train","unbalanced_train"]:
        for label in labels:
            targetpath=os.path.join(target,phase,label+'.csv')
            resultpath=os.path.join(DIR,"result",phase,label)
            itemCounter=0

            os.makedirs(resultpath, exist_ok=True)
            os.chdir(resultpath)
            executor = ThreadPoolExecutor(max_workers=MAXPROCESS)
            print("-------------")
            print(phase,":",label,"start")
            with open(targetpath) as f:
                
                for line in readCSV(f):
                        #(プロセス数、ファイル数)最大個数を超えているかで足切りを行う
                    if (len(glob.glob("./*.wav")) < MAXWAVES):#ファイル数で切り捨てる
                        
                        #スレッド化する
                        executor.submit(download_line,line)
                        #download_line(line)
                        time.sleep(0.7)
            executor.shutdown()
            os.chdir(DIR)

def download_line(line):
    myid,start,end,labels = line
    #dprint("{},{},{}:{}".format(myid,start,end,labels))

    
    dprint("{}:{}:{}~{}".format(labels,myid,start,end))
    #一時用の_longファイルを消す関数
    pp = lambda x: os.remove(x+'_long.wav') if (os.path.exists(x+"_long.wav")) else None
    try:
        #ダウンロード前に、そのデータがダウンロードされているかを見る
        if (not os.path.exists(myid+".wav")):
            dprint("DLします")
            
            myyoutubedl(myid)

            dprint(myid+start+end+"DL完了、切り取りします")
            ffmpegCat(myid,start,end)
            dprint(myid+"切り取り完了")#missってる

        else:
            dprint("もうあります")
        #pp(myid)
        return 
    except:
        print(myid,":miss!!")
        #pp(myid)
        return 




def getLabels(target):
    result=list()
    
    with open(os.path.join(target,'labels.csv')) as f:
        lines=readCSV(f)
        
        for line in lines:
            result.append(line[0])
    return result

def readCSV(f):
    return csv.reader(f, delimiter=',', doublequote=True, lineterminator="\r\n", quotechar='"', skipinitialspace=True)


if __name__ == '__main__':
    main()