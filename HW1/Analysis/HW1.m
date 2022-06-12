
%This will read the table and make a table
%If you double click on the Table in your Worksapce after
%you run this, you can see what is in the table.
df = readtable("compute_pi_1.csv");
mpi_df = readtable("mpi_compute_pi_1.csv");
tpn_df = readtable("mpi_compute_pi_tpn_1.csv");

%Q1 Execution Time vs p
df_Time = df.Time_sec_(1:14);
df_p = df.Threads(1:14);
df_baseTime = df_Time(1);
df_speedup = df_baseTime./df_Time;
df_efficiency = df_speedup./df_p;


tbl = table(df_Time, df_speedup, df_efficiency);
arr = table2array(tbl);
s = stackedplot(df_p,arr);
s.GridVisible ="on";
s.DisplayLabels = {'Time (sec)', 'Speedup', 'Efficiency'};
s.XLabel = "Threads";
s.LineProperties(1).Color = "k";
s.LineProperties(1).Marker = "o";
s.LineProperties(2).Color = "b";
s.LineProperties(2).Marker = "s";
s.LineProperties(3).Color = "r";
s.LineProperties(3).Marker = "*";
ax = findobj(s.NodeChildren, 'Type','Axes');
set(ax, 'Xscale', 'log')
grid on

%Also find min or max
%[time_min,time_id] = min(df_Time);
%[speedup_max, speedup_id] = max(df_speedup);
%ax = flipud(findobj(s.NodeChildren, 'Type','Axes'));

saveas(s,"Q1n1e8.png")

%Q2 same as 1 but with 10^10
df_Time = df.Time_sec_(15:28);
df_p = df.Threads(15:28);
df_baseTime = df_Time(1);
df_speedup = df_baseTime./df_Time;
df_efficiency = df_speedup./df_p;


tbl = table(df_Time, df_speedup, df_efficiency);
arr = table2array(tbl);
s = stackedplot(df_p,arr);
s.GridVisible ="on";
s.DisplayLabels = {'Time (sec)', 'Speedup', 'Efficiency'};
s.XLabel = "Threads";
s.LineProperties(1).Color = "k";
s.LineProperties(1).Marker = "o";
s.LineProperties(2).Color = "b";
s.LineProperties(2).Marker = "s";
s.LineProperties(3).Color = "r";
s.LineProperties(3).Marker = "*";
ax = findobj(s.NodeChildren, 'Type','Axes');
set(ax, 'Xscale', 'log')
grid on

saveas(s,"Q2n1e10.png")

%Q4 Error vs n
df_n = df.Trials(29:34);
df_err = df.Error(29:34);
df_err = df_err.*100;
p = semilogx(df_n, df_err, "--bs");
ylabel("Error (%)")
xlabel("Points (n)")
grid on
saveas(p,"Q4.png")

%Q5 Same as Q1,2
df_Time = mpi_df.Time_sec_(1:7);
df_p = mpi_df.Processes(1:7);
df_baseTime = df_Time(1);
df_speedup = df_baseTime./df_Time;
df_efficiency = df_speedup./df_p;


tbl = table(df_Time, df_speedup, df_efficiency);
arr = table2array(tbl);
s = stackedplot(df_p,arr);
s.GridVisible ="on";
s.DisplayLabels = {'Time (sec)', 'Speedup', 'Efficiency'};
s.XLabel = "Processes";
s.LineProperties(1).Color = "k";
s.LineProperties(1).Marker = "o";
s.LineProperties(2).Color = "b";
s.LineProperties(2).Marker = "s";
s.LineProperties(3).Color = "r";
s.LineProperties(3).Marker = "*";
ax = findobj(s.NodeChildren, 'Type','Axes');
set(ax, 'Xscale', 'log')
grid on

saveas(s,"Q5n1e8.png")

%Q6 time vs tpn
df_tpn = tpn_df.NumberOfTasks_Node;
df_time = tpn_df.Time_sec_;
h = semilogx(df_tpn, df_time, "--bs");
ylabel("Time (sec")
xlabel("Tasks per Node")
grid on
saveas(h,"Q6.png")

%Q7 speedup vs n
df_p1Time = mpi_df.Time_sec_(12:15);
df_p64Time = mpi_df.Time_sec_(8:11);
speedup = df_p1Time./df_p64Time;
df_n = mpi_df.Intervals(8:11);
g = loglog(df_n, speedup, "--bs");
ylabel("Speedup (sec)")
xlabel("Intervals (n)")
grid on
saveas(g,"Q7.png")

%Q7.2 n vs error
df_n = mpi_df.Intervals(8:11);
df_err = mpi_df.Error(8:11);
df_err = df_err.*100;
f = loglog(df_n, df_err, "--bs");
ylabel("Error (%)")
xlabel("Intervals (n)")
grid on
saveas(f,"Q72.png")


