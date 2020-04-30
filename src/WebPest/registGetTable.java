package WebPest;

import java.io.*;
import java.util.ArrayList;
import java.lang.String;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class registGetTable {
    public  ArrayList<Classinfo> Classform = new ArrayList<>();

    public static void main(String[] args) {
        registGetTable GetTable = new registGetTable();
        GetTable.Start();
    }

    public void Start() {
        try {
            registGetTable GetTable = new registGetTable();
            Classinfo list[] = GetTable.ReForm(GetClassInfo());
            for (int i = 0; i < list.length; i++) {
                Classform.add(list[i]);
            }
            System.out.println("课表存储完成"+"size="+list.length);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public static List<String> GetClassInfo() throws Exception {
        FileInputStream fis = new FileInputStream("G:\\IDEA\\MyWeb\\Classtable.txt");
        BufferedInputStream bis = new BufferedInputStream(fis);
        BufferedReader reader = new BufferedReader (new InputStreamReader(bis,"utf-8"));
        String regex = "(align=\"Center\" rowspan)([\\s\\S])*?(</td>)";//正则匹配表达式
        Pattern pt = Pattern.compile(regex);
        String str;
        StringBuffer result = new StringBuffer();
        while (reader.ready()) {
            result.append((char)reader.read());
        }
        str=result.toString();
        Matcher mt = pt.matcher(str);
        ArrayList<String> ClassList = new ArrayList<String>();
        while (mt.find()) {
            ClassList.add(mt.group(0));
        }
        return ClassList;//返回HTMLCLASS信息
    }

    public class Classinfo {
        public String ClassName;
        public String ClassRoom;
        public String Teacher;
        public String type;
        public String Week;

        public Classinfo() {
            String ClassName = "";
            String ClassRoom = "";
            String Teacher = "";
            String type = "";
            String Week = "";

        }

        public void ClassOut() {
            System.out.println("________________________");
            System.out.println("课程为:" + this.ClassName);
            System.out.println("类型为:" + this.type);
            System.out.println("教师为:" + this.Teacher);
            System.out.println("日期为:" + this.Week);
            System.out.println("教室为:" + this.ClassRoom);
        }

        public void Save() throws Exception {

        }

    }


    public Classinfo[] ReForm(List<String> Class) throws Exception {

        Classinfo[] Cs = new Classinfo[Class.size()];
        for (int i = 0; i < Class.size(); i++) {
            Cs[i] = new Classinfo();
        }
        for (int i = 0; i < Class.size(); i++) {
            int pos1 = 1;
            int pos2 = 1;
            String Temp = Class.get(i);
            pos1 = Temp.indexOf(">", pos1);//课程>
            Cs[i].ClassName = Temp.substring(pos1 + 1, (pos2 = Temp.indexOf("<", pos1)));
            pos1 = Temp.indexOf(">", pos2);//类型>
            Cs[i].type = Temp.substring(pos1 + 1, (pos2 = Temp.indexOf("<", pos1)));
            pos1 = Temp.indexOf(">", pos2);//时间>
            Cs[i].Week = Temp.substring(pos1 + 1, (pos2 = Temp.indexOf("<", pos1)));
            pos1 = Temp.indexOf(">", pos2);//名字>
            Cs[i].Teacher = Temp.substring(pos1 + 1, (pos2 = Temp.indexOf("<", pos1)));
            pos1 = Temp.indexOf(">", pos2);//地点>
            Cs[i].ClassRoom = Temp.substring(pos1 + 1, (pos2 = Temp.indexOf("<", pos1)));
        }
        return Cs;
    }

}