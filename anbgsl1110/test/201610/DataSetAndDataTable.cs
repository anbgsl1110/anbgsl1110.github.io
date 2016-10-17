//DataTable
SqlDataAdapter da = SqlDataAdapter(cmd);
DataTable dt = new DataTable();
da.Fill(dt);//直接把结果放到DataTable中

//DataSet
SqlDataAdapter da = SqlDataAdapter(cmd);
DateSet dt = new DataSet();
da.Fill(dt);//数据结果放到DataSet中，若要使用那个DataTable可以这样使用dataset[0]

SqlDataAdapter da = new SqlDataAdapter(cmd);
DataSet dt = new DataSet();
da.Fill(dt,"table1");//使用的时候可以这样取DataTable：DataSet["table1"];




