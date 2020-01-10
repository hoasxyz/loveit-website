# C#读取.accdb文件


也是通过ODBC连接，之前写了个用R连接ODBC的[流程](https://hoas.xyz/post/read-access-and-mssql-in-r/)，这次是因为课程原因需要使用C#，不过从上次的经验来看，Access和MS SQL应该相差不大。

ODBC非常稳定，好像2009年是最后一次版本大更，R包**RODBC**也几年么有更新了，现在都还能用。	

<!--more-->

# 连接测试

直接在Form中新建一个`button`即可测试：

```cs
using System.Data.OleDb;

private void button1_Click(object sender, EventArgs e)
{
  try
  {
    OleDbConnection conn = new OleDbConnection();
    string connStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=";
    connStr += @"E:\1WHU\junior2\Csharp\teamwork\teamwork.accdb";
    MessageBox.Show("当前连接字符串为:\n" + connStr + "\n");
    conn.ConnectionString = connStr;
    conn.Open();
    if (conn.State == ConnectionState.Open)
      MessageBox.Show("连接成功");
    conn.Close();
    if (conn.State == ConnectionState.Closed)
      MessageBox.Show("关闭成功");
  }
  catch (Exception ex)
  {
    MessageBox.Show("连接失败，原因是：\n" + ex.Message);
  }
}
```

另外使用完后不要忘了关闭数据库连接：

```cs
conn.Close();
conn.Dispose();
```

需要注意的是`Microsoft.Jet.OLEDB.4.0`的Oledb的连接方式是比较老的连接方式，而07以后的Oledb连接方式将改成`Microsoft.ACE.OLEDB.12.0`。在[这里](https://hoas.xyz/post/read-and-write-excel-in-cs/)其实提到过不过没有指明。

改后的连接变成了`Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\myFolder\*.accdb;Persist Security Info=False;`这样才能识别新版的office。

teamwork时，`connStr`字符串的路径要改成自己电脑上的路径！

比较好的一个参考链接：https://blog.csdn.net/qq_15505341/article/details/79033243

# 提取所有表名

参考链接：

1. https://www.cnblogs.com/yunfeng83/p/4436437.html
2. https://blog.csdn.net/lanman/article/details/3982385

# 数据导入

在[第一个链接](https://blog.csdn.net/qq_15505341/article/details/79033243)中已经有了比较明确的阐述，数据库的主体内容不变的情况下，创建`datatable`来存放每一个表格，因此在接下来的计算中，**都需要事先将数据库中的表格们放进datatable中**，再从datatable中提出数据使用。下面是将数据库的表格放进datatable中的流程：

```cs
OleDbConnection conn = new OleDbConnection();

string db_cmd_param = "select * from param";// SQL语句
OleDbDataAdapter db_adapter = new OleDbDataAdapter(db_cmd_param, conn); // 创建适配对象
DataTable db_param = new DataTable(); // 新建表对象
db_adapter.Fill(db_param);// 填充表内容

// 引用表数据
textBox1.Text = db_param.Rows[0][0].ToString();
textBox7.Text = db_param.Rows[0][1].ToString();
textBox2.Text = db_param.Rows[0][2].ToString();
textBox8.Text = db_param.Rows[0][3].ToString();
textBox3.Text = db_param.Rows[0][5].ToString();
textBox9.Text = db_param.Rows[0][6].ToString();
textBox4.Text = db_param.Rows[0][7].ToString();
textBox10.Text = db_param.Rows[0][4].ToString();
textBox5.Text = db_param.Rows[0][8].ToString();
textBox11.Text = db_param.Rows[0][9].ToString();
textBox6.Text = db_param.Rows[0][10].ToString();
```

如果有更好的方法欢迎留言:blush:，我只发现了这种“爬格子”式的笨办法。其它的表格也是按照以上对应的步骤来，不过可以将`datatable`放进`dataset`中再从`dataset`中调用子表格，或者能否考虑用个循环一次把所有的`datatable`放进一个`dataset`中，哎，这思路对我来说只能想想，因为这里是C#，不是R。

# 提示

秉承不坑队友的天真想法，我在此记录下一些提示：

1. 如果想实现水电站特征参数groupbox中的数据的交互使用（用更改后的数据再运行），那么建议在运行button中重读groupbox中textbox里的内容。因为断连数据库后水电站特征参数groupbox中textbox里的数据依然还有。不过这里还好，只有一个数据库；
2. 也就是因为只有一个数据库，所以水电站特征参数groupbox中的label我全部写死了，我找过如何以代码形式自定义label的位置以及循环输出label×（比如label2，label3，...）的text，折腾半天后还是算了吧，别瞎给自己找麻烦；
3. 本来`数据库连接`这个按钮是用来在路径中选择文件的，这里为了方便直接赋值了，出一个messagebox只是为了确定是否点击成功。

# 打开新程序

该问题实质是如何通过C#代码启动一个新的进程：

```cs
private void 水库洪水调节计算ToolStripMenuItem_Click(object sender, EventArgs e)
{
  Process.Start(@"D:\水文预报程序\水文预报\bin\Debug\水文预报.exe");
}

//或者
//按钮事件中加
System.Diagnostics.Process ps = new System.Diagnostics.Process();
ps.StartInfo.FileName = @"E:\Music\QQMusic.exe";
ps.Start();
```

不知道对不对，水库洪水调节计算指的是`ToolStripMenu`的名字。

另一个[简单的方法](https://zhidao.baidu.com/question/264907314902042525.html?qbl=relate_question_0)亲测可以：

```r
string path = "cmd.exe";
System.Diagnostics.Process.Start(path);

string path = Application.StartupPath + "\\thrlay.exe";
System.Diagnostics.Process.Start(path);
```

