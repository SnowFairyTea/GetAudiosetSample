import os,sys,csv
import youtube_dl

dprint=lambda x:print(x) 

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
            with open(targetpath) as f:
                for line in readCSV(f):
                    download_line(line)

def download_line(line):
    myid,start,end,labels = line
    #dprint("{},{},{}:{}".format(myid,start,end,labels))
    #todo:ダウンロードしてwavに変換する。youtubedlのREADMEの下のほうにやり方乗ってそう



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