import os
import re

# Task 1:

def  open_file():
    while True:
        filename=input("Enter a filename:")
        try:
            dir=os.path.join("D:\DS_MMC\Module_1\Final_project\Data Files",f"{filename}.txt")
            with open(dir,"r") as f:
                data=f.read()  
            print(f"Successfully opened {filename}")
            break 
        except :
            print("Sorry, I can't find this filename")
  
    return data , filename


# Task 2:
def data_analys(data):
    lst = data.split("\n")
    student = []
    error_26 = []
    error_N = []
    good_data = []
    print("**** ANALYZING ****")
    for i in range(len(lst)):
        student.append(lst[i].split(","))
        if len(student[i]) != 26:
            print("Invalid line of data: does not contain exactly 26 values:")
            print(lst[i])
            error_26.append(list[i])
        elif bool(re.search(r"\b[N][0-9]{8}\b", student[i][0])) != True:
            print("Invalid line of data: N# is invalid:")
            print(lst[i])
            error_N.append(list[i])
        else: 
            good_data.append(student[i])
    if len(error_26)+len(error_N) == 0: print("No errors found!")
    print("**** REPORT ****")
    print(f"Total valid lines of data: {len(lst)-len(error_26)-len(error_N)}")
    print(f"Total invalid lines of data: {len(error_26)+len(error_N)}")
    return good_data


# Task 3:
def max_count(dict):
    max_value=0
    for key, value in dict.items():
        if max_value < value:
            max_value = value
    for key, value in dict.items():
        if max_value == value:
            print(f"{key} - {max_value} - {max_value/25}")
def  scoring(answer_key,data):

    answer_key = answer_key.split(',')
    result = []
    skip_answer = {}
    wrong_answer = {}
    for i in data:
        score = 0
        for j in range(1,len(i)):
            if i[j] == answer_key[j-1]:
                score += 4
            elif i[j] == "":
                pass
                if j in skip_answer:
                    skip_answer[j]+=1
                else:
                    skip_answer[j]=1
            else:
                score -= 1
                if j in wrong_answer:
                    wrong_answer[j]+=1
                else:
                    wrong_answer[j]=1
        result.append(score)
    print(f"Total student of high scores:{len([1 for i in result if i>80])}")
    print(f"Mean (average) score:{sum(result)/len(result)}")
    print(f"Highest score:{max(result)}")
    print(f"Lowest score:{min(result)}")
    print(f"Range of scores:{max(result)-min(result)}")
        
    result2=result.copy()
    result2.sort()
    length = len(result2)
    if length % 2 == 0:
        median = (result2[length // 2 - 1] + result2[length // 2]) / 2
    else:
        median = result2[length // 2]
    print(f"Median score:{median}")
    print("Question that most people skip:")
    max_count(skip_answer)
    print("Question that most people answer incorrectly:")
    max_count(wrong_answer)
    return result


# Task 4:
while True:
    data, filename = open_file()
    good_data = data_analys(data)
    answer_key = "B,A,D,D,C,B,D,A,C,C,D,B,A,B,A,C,B,D,A,C,A,A,B,D,D"
    result = scoring(answer_key,good_data)
    path= "D:\DS_MMC\Module_1\Final_project\Data Files\ " + filename + "_grade.txt"
    with open(path,"w") as f:
        for i in range(len(good_data)):
            f.write(good_data[i][0]+","+str(result[i])+"\n")
        print("Sucessfully write file " + filename + "_grade.txt \n")
    f.close()
    choice = input("Do you want input more? (0: không, 1: có)")
    if choice == "0":
        print("Goodbye - Thank you !")
        break