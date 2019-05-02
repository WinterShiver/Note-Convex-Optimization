# 凸优化 CH 2 对偶与最优性条件

标签（空格分隔）： 凸优化

---
[TOC]

## 拉格朗日函数
* 拉格朗日函数：$L(x,\lambda)=f(x)+\lambda^Tg(x)$
带等式约束：$L(x,\lambda)=f(x)+\lambda^Tg(x)+v^Th(x)$
* 拉格朗日对偶函数$L_D(\lambda)=\underset{x}{inf}\ L(x,\lambda)$
带等式约束：$L_D(\lambda,v)=\underset{x}{inf}\ L(x,\lambda,v)$
* 性质
  * $L_D(x)$是凹函数
  * $\lambda\geq0$时，对偶函数是原函数的下界
  * $L_D(\lambda)=-f^*(-\lambda)$
  （共轭函数：$f^*(\lambda)=\underset{x\in dom f}{sup}(\lambda^Tx-f(x))$，即f(x)与x的线性函数的最远距离）
  因为共轭函数必为凸函数，所以此性质也说明$L_D(x)$是凹函数
  
## 拉格朗日对偶问题
$max\ L_D(\lambda,v)$
$\lambda\geq0$


## 弱对偶和强对偶
* 原函数：$L_P(x)=\underset{\lambda\geq0}{sup}\ L(x,\lambda)$
$min\ L_P(x)$和原问题等价（见纸质推导1）
* 弱对偶(极大极小不等式）：
$\begin{aligned}
min\ L_P(x) & = \underset{x}{min}\ \underset{\lambda}{max}\ L(x,\lambda,v) \\
 & \geq\underset{\lambda}{max}\ \underset{x}{min}\ L(x,\lambda,v) \\
 & =max\ L_D
\end{aligned}$
对偶问题的解是原问题解的下界
启发：求解原问题时可以先求解对偶问题（凸优化问题），对偶问题的解必定不大于原问题的最优解（给出下界，保底）
* 强对偶：上述不等式等号严格成立
一种很理想的情况，此时对偶问题的解就是原问题的解（纸质推导2）。
解释：极大极小不等式的鞍点
凸优化问题往往能满足强对偶条件。
* 强对偶的成立条件：Slater约束品性（内点）
存在可行解集的内点严格满足不等式条件（严格＜）
解释：对应有严格凸子集的凸集

## KKT方程
强对偶性成立时的充要条件：原问题的解是KKT方程的解
$g(x)\leq0$,$h(x)=0$（约束条件）
$\lambda\geq0$（$v$没有要求）
$\lambda^Tg(x)=0$（对$g(x)$的松弛约束）
$\bigtriangledown f(x)+\lambda^T\bigtriangledown g(x)+v^T\bigtriangledown h(x)=0$（主方程）