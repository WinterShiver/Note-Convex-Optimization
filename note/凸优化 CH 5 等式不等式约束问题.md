# 凸优化 CH 5 等式不等式约束问题

标签（空格分隔）： 凸优化

---
[TOC]

## 问题描述
* $\underset{x}{min}\ f_0(x)$
$s.t.f_i(x)\leq0(1\leq i\leq m),Ax=b$
* $f_0(x)$是至少二阶连续可导的强凸函数
* 等式约束中A是p*n维矩阵（n是变量的维数）
A是满秩的,$rank\ A=p$
* $h(x)=Ax-b$,$\bigtriangledown h(x)=A$

## 不等条件的消解

### 示性函数
示性函数$I_-(u)=
\begin{cases} \\
\infty, u>0 \\
0,u\leq0 \\
\end{cases}$
利用示性函数,问题转化为$\underset{x}{min}\ f_0(x)+\sum_{i=1}^{m}I_-(f_i(x)), s.t.Ax=b$，也是凸优化问题，也能给出同样的最优解
但我们希望目标函数性态能再好一点（可微）

### 对数障碍函数/近似示性函数
* 近似示性函数$\hat{I}_-(u)=-\frac{1}{t}log(-u)$对示性函数做了很好的模拟，t取越大越好
使用对数障碍函数表示这个和，$\phi(x)=\sum_{i=1}^{m}-log(-f_i(x))$
问题转化为$\underset{x}{min}\ tf_0(x)+\phi(x), s.t.Ax=b$，也是凸优化问题，也能给出同样的最优解
* 对数障碍函数的实质是把不等约束放宽到了$f_i(x)\leq1/t$，下文的中心路径法对应KKT方程的连续变形，最终逼近最优解及其KKT
* 参数为t的近似问题，求解误差上界为$m/t$，即$p^*(t)-p^*\leq m/t$
（利用KKT和对偶函数性质证明）

### 障碍方法
* 直接求解
因为t可以控制求解精度，所以可以直接设定t，求解对应的问题来获得对应精度的解
问题：t较大时Hessian矩阵在可行集边界上误差较大
* 障碍方法求解
针对一系列t解一系列问题，把每一个问题的结果作为下一个问题的初始点，直到t符合精度要求，求解结果序列称为中心路径
t：从$t_0$开始，以$\mu$为公比的等比数列
* 阶段2：从满足等式不等式条件的点出发，求解中心路径，迭代求问题的解

## 寻找可行点（阶段1）
障碍方法需要从一个满足等式不等式条件的点出发，需要提前找这个点
阶段1对于平凡的初始点$x_0$设计一个子问题（等式不等式优化问题），执行障碍方法求解以获得下一阶段的初始点；因此，问题设计的重点是初始点必须可行

### 满足等式约束条件的$x_0$
* 问题
$\underset{s,x}{min}\ s$
$s.t.f_i(x)\leq s,Ax=b$
* 此问题总严格可行，因为s也是优化变量，相当于不等式约束是$g_i(x,s)=f_i(x)-s\leq0$，初始值$s_0$取$max(f_i(x_0))$即可
* 迭代到$s<0$说明有严格可行解，迭代到$s>0$说明解不存在，但获得的解已经是这种情况下能用的最好的解了，所以也没事

### 不满足等式约束条件的$x_0$
* 对应不可行初始点的牛顿
* 先上松弛约束，把做不到的约束丢进目标函数，从而保证严格可行性，把不可行的部分变成优化目标；再通过迭代助教优化
$\underset{z_i,s,x}{min}\ t_0f_0(x)-\sum_{i=1}^{m}log(s-f_i(x))$
$s.t.Ax=b,s=0$

### 不位于可行解集的$x_0$
* 对应不可行初始点的牛顿
* 思路还是为保证严格可行性而凑格式
$\underset{s,x}{min}\ t_0f_0(x+z_0)-\sum_{i=1}^{m}log(s-f_i(x+z_i))$
$s.t.Ax=b,s=0,z_i=0(0\leq i\leq m)$

## 基于原对偶残差的搜索
* 对标等式约束的原对偶残差方法
* 减小量：原对偶残差，多了一个中心残差
$r_t(x,\lambda,v)=\left[
\begin{array} \\
r_{dual} \\
r_{cent} \\
r_{pri} \\
\end{array}
\right]=\left[
\begin{array} \\
\bigtriangledown f_0(x)+Df(x)^T\lambda+A^Tv \\
\lambda f(x)-1/t \\
Ax-b \\
\end{array}
\right]
$
* 下降方向（对应等式约束的原对偶下降方向）
$\frac{\partial r_t(x,\lambda,v)}{\partial (x,\lambda,v)}
\left[
\begin{array} \\
d_x \\
d_\lambda \\
d_v \\
\end{array}
\right]=-r_t(x,\lambda,v)
$
* 参数t：$t=\frac{\mu m}{\eta(x,\lambda)}=\frac{\mu m}{-Df(x)^T\lambda}$
* 各种停止的误差参数：$r_{dual}$和$r_{pri}$用一个$e_{feas}$,$\eta(x,\lambda)$用一个e，不知道啥意思
