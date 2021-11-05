import ffmpeg
import shutil

def ffmpegCat(myid,start,end):

    myid,start,movietime=myid,float(start),float(end)-float(start)
    print(myid,start,movietime)
    stream = ffmpeg.input(myid+'.wav')
    stream = ffmpeg.output(stream, "./"+myid+'_tmp.wav', ss=start, t=movietime)
    ffmpeg.run(stream)
    print("runfinish")
    shutil.move(myid+'_tmp.wav',myid+'.wav')


if __name__ == '__main__':
    ffmpegCat("--PJHxphWEs","5","10")