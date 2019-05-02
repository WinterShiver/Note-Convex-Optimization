# 凸优化 CH 4 等式约束问题

标签（空格分隔）： 凸优化

---
[TOC]

## 问题描述
* $\underset{x}{min}\ f_0(x)$
$s.t.Ax=b$
* $f_0(x)$是至少二阶连续可导的强凸函数
* 等式约束中A是p*n维矩阵（n是变量的维数）
A是满秩的,$rank\ A=p$
* $h(x)=Ax-b$,$\bigtriangledown h(x)=A$

## 直接求解
* 理论上可以直接列解KKT方程来求解问题
存在最优解$x^*$等价于$
\begin{cases}
Ax^*=b \\
\bigtriangledown f(x^*)+{v^*}^TA=0 \\
\end{cases}
$有解
不难发现$v^*=-(AA^T)^{-1}A\bigtriangledown f(x^*)$，这个结果后文有用
* 一个特殊情况
对于二次函数求解，KKT方程可以写成矩阵形式：
$
\left[
\begin{array} \\
P & A^T \\
A & 0 \\
\end{array}
\right]
\left[
\begin{array} \\
x \\
v \\
\end{array}
\right]=
\left[
\begin{array} \\
-Q \\
b \\
\end{array}
\right]
$
对后文的迭代求解有指导意义
* 大多数情况，KKT方程很难直接求解

## 破坏原问题结构求解
### 消除等式约束
* 对x进行仿射以降维，使p个等式约束被化解，形成的新变量为n-p维无约束变量
$$\{x:Ax=b\}=\{Fz+\hat{x}:z\in \mathbb{R}^{n-p}\}$$
$\hat{x}$是特解，$A\hat{x}=b$
$F$是$A$的零空间中的矩阵，n*n-p维，$AF=0$
注：变成无约束问题之后就没有KKT方程了，因为不再有对偶
* F的无关性
任何一个零空间内的矩阵都可用作消除矩阵
消除矩阵乘以一个满秩的矩阵还是消除矩阵

### 对偶方法求解
直接列出对偶问题并求解
$$\underset{v}{max}\ -b^Tv-f^*(-A^Tv)$$

## 迭代求解

### 牛顿+回溯 从可行点开始
* 额外要求：从可行点$Ax_0=b$开始；每一步下降都可行,即$Ad_{nt}=0$
* 牛顿方向的选取：满足方程
$
\left[
\begin{array} \\
\bigtriangledown^2f(x) & A^T \\
A & 0 \\
\end{array}
\right]
\left[
\begin{array} \\
d_x \\
w \\
\end{array}
\right]=
\left[
\begin{array} \\
-\bigtriangledown f(x) \\
0 \\
\end{array}
\right]
$
* 讨论
  * 跟二次函数对应，可以还用之前二阶泰勒来解释
  * 可以解释成最优性条件的线性近似方程组的解
* 性质
  * 可以保住之前的一切关于收敛性的计算结果（减小量定义、阻尼、二次、各个数值）
  * 仿射不变性：$x=Ty$，则$d_{x,nt}=Td_{y,nt}$
  可以回代看看牛顿方向的定义方程是怎么变的
  这种换元可以让我们选取合适的T来简化计算
  * 从可行点开始牛顿，每步迭代过程和消除等式约束+无约束牛顿完全相同，即牛顿方向相同（乘个F），减小量相同，下一个序列点相同
  证明：根据仿射不变性，对应着算

### 牛顿+回溯 从不可行点开始
* 问题转化：最优化对偶残差$
r
\left(
\begin{array} \\
x \\
v \\
\end{array}
\right)=
\left[
\begin{array} \\
r_{dual}(y)=\bigtriangledown f(x)+A^Tv \\
r_{pri}(y)=Ax-b \\
\end{array}
\right]
$，通过迭代使其下降到0（满足可行点的KKT）
* 牛顿方向的选取：尽快完成对偶残差的最优化，使得$r
\left(
\begin{array} \\
x+d_x \\
v+d_v \\
\end{array}
\right)
$下降最快
具体：牛顿方向应满足方程$
\left[
\begin{array} \\
\bigtriangledown^2f(x) & A^T \\
A & 0 \\
\end{array}
\right]
\left[
\begin{array} \\
d_x \\
w \\
\end{array}
\right]=
\left[
\begin{array} \\
-\bigtriangledown f(x) \\
Ax-b \\
\end{array}
\right]
$
理解：对应可行牛顿方向选取的线性近似理解，在迭代格式中$r_{pri}(y_k+d_{y,k})$的值应由上一次迭代的中心残差计算得到，所以约束条件的迭代格式写为$Ad_{x,k}=Ax_k-b$，其中$d_{x,k}$决定了$x_{k+1}-x_k$（的方向）
* 回溯停止条件：利用残差的2范数
$$||r(y+td_y)||_2>(1-\alpha t)||r||_2,y=
\left(
\begin{array} \\
x \\
v \\
\end{array}
\right)
$$
此处使用$||r||_2$是因为r在$d_y$方向上的方向导数为$-||r||_2$，即$t=0$时$\frac{d}{dt}(||r(x+td_y)||_2)=-||r||_2$，使用这个量对应回溯搜索中要求的方向导数
* 可行性 
  * 牛顿方向可以保证对偶残差的范数一直减小（在点处其2范数对步长t的导数是负的2范数），但是不能保证下降
  因此，残差以指数速度下降（线性收敛），迟早会降为0
  实际上残差方向一直不变，长度等比减小
  * 残差降为0的标志：步长取得1，再往下都是可行方向可行点了，已经达到误差允许的范围$Ax-b=0$，与可行牛顿无异；此时应该修改牛顿方向的计算和回溯停止条件，回归正常的牛顿
  在下面的推导中没管这个误差，还是正常按设定误差算，经过两个阶段之后近似收敛到可行点，再按可行点牛顿下降来做
  * 有的时候就是不可行
* 收敛性分析
  * 要求和参数
  > * r在初始点的水平集合S是凸集
  > * KKT的逆矩阵$Dr(y)$有上界$K$，即$||Dr(y)^{-1}||_2\leq K$
  > * Lipschitz连续：$||Dr(y)-Dr(y_0)||_2\leq L||y-y_0||_2$
  > * 这些条件可以保证最优解和相应的对偶变量一定存在

  * 取$t_{max}=inf\{t>0:r(y+td_y)=0\}$，有$||r(y+td_y)||_2\leq(1-t)||r(y)||_2+\frac{1}{2}K^2Lt^2||r(y)||_2^2,t\leq t_{max}$
  * 阻尼牛顿阶段
  > * 回溯牛顿停止条件：$t_k\leq\frac{1}{K^2L||r(y_k)||_2^2}$
  每一步的上界因梯度而异，但不妨碍导出结果
  > * 下降量：$\gamma=\alpha\beta\frac{K^2}{L}$

  * 二次收敛阶段：
  > * 阶段的参数：$\eta=\frac{1}{K^2L}$
  > * 步长：$t=1$
  > * 二次收敛性：$||r_{k+1}||_2\leq\frac{K^2L}{2}||r_k||_2$

