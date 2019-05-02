# 凸优化 CH 3 通用下降方法

标签（空格分隔）： 凸优化

---
[TOC]

## 准备工作
### 问题描述
目标函数是至少二阶连续可导的凸函数
性质：最优解充要于梯度为0，且水平集合为闭集
二阶泰勒近似：$$f(x)=f(x_0)+\bigtriangledown^Tf(x_0)(x-x_0)+\frac{1}{2}(x-x_0)^T\bigtriangledown^2f(x)(x-x_0)$$
经常用这个式子直接相等时的情况做估计，以下的迭代求解都基于等式
### 强凸性
* 定义
$\exists m>0,s.t.\bigtriangledown^2f(x)\geq mI,\forall x\in dom\ f$，即二阶梯度（Hessian矩阵）有正的下界
* 上部限界（经常成立）：
$$mI\leq\bigtriangledown^2f(x)\leq MI$$
估计m和M的好方法:矩阵的最大最小特征值
* 性质：
  * 结合二阶展开的等式使用
  $$f(x)\geq f(x_0)+\bigtriangledown^Tf(x_0)(x-x_0)+\frac{m}{2}||x-x_0||_2^2$$
  * 目标函数值与最优值（最小值的差）由梯度限定
  $$e(x)=f(x)-p^*\leq\frac{1}{2m}||\bigtriangledown f(x)||_2^2 \tag{估计值下界}$$
  因此，通用下降方法可以判断梯度作为停止条件

## 无约束最小化方法：通用下降方法
求解无约束问题使用基于迭代的方法，取一点的序列以迫近梯度为0的点
```Python
find x # 取初值点
while |gradient x|>e # 有时也会采取不是梯度范数的其他停止条件
# 有时这里也用|gradient x|>2me，e对应原函数误差
   find d # 找下降方向d
   # 下降方向：梯度与方向内积<0，即局部一阶凸
   find t # 找下降步长t
   # 下降步长：只要使函数值下降即可，即f(x+td)<f(x)
   upgrade x: x=x+td
end
```
* 以下记原始误差$e_0=e(x_0)=f(x_0)-p^*$。下文讨论收敛性时，实际讨论的$e$也是达到$f(x)-p^*<e$的情况,不是函数梯度模的$e$。算法中用梯度表示迭代停止的停止阈值对应这里的$2me$。
* 这里梯度没有要求具体是哪个范数，不过回溯下降和2范数联系紧密，这里最好采取2范数；最速下降最好采取和最速方向确定相同的范数。牛顿下降使用的是牛顿减小量。

## 线性下降方法介绍

### 确定下降方向的办法
* 梯度下降：取负梯度方向为下降方向
* 最速下降：基于方向导数，找下降速度最快的方向
  $d_{nsd}=argmin\{\bigtriangledown^Tf(x)*d,s.t.||d||=1\}$
在下文最速下降部分，没有特殊声明的范数（没有下标的范数$||\cdot||$）就是梯度在此处的范数，下标为*的范数$||\cdot||_*$是其对偶范数

  
### 最速下降：一些补充
* 最速下降方向使方向导数最小（绝对值最大的负值）
* 最速下降方向是单位方向
* 非规范化最速下降：最速下降方向*梯度的对偶范数
$d_{sd}=d_{nsd}*||\bigtriangledown f(x)||_*$
* 一些特殊情况
  * 2范数：非规范化最速下降方向就是负梯度方向
  * 1范数：等价于每步只改动梯度最大分量的维度，往下降方向（正或负）走$\frac{\partial f}{\partial x_i}$（当前点的偏导数）
* 梯度和最速的重要区别：最小化的参考标准不同
$\bigtriangledown^Tf(x)*d=-||d||_2^2$
$\bigtriangledown^Tf(x)*d_{sd}=-||d_{sd}||_*^2$
如果最速下降采用2范数，则确定的下降方向就是负梯度方向

### 确定下降步长的方法
* 精确直线搜索：针对步长$t$做单变量优化$\underset{t>0}{min}f(x+td)$，找到精确的最小值
* 回溯直线搜索：先取步长$t=1$，然后每次乘一个公比$\beta<1$来缩
回溯停止条件：$f(x+td)<f(x)+\alpha\bigtriangledown^Tf(x)*td$，$0<\alpha<0.5$

### 回溯直线：一些补充
* $\bigtriangledown^Tf(x)*td$对应目标函数在下降方向上的方向导数
后文可以看到，有时方向导数的数值比较容易通过其他量计算得到，此时也会用跟其他量有关的表达式表示，但实质是一样的
* 参数$\alpha$,$\beta$的作用
  * $\alpha$的作用：$\bigtriangledown^Tf(x)*td$是负的，而$f(x+td)\to f(x)+\bigtriangledown^Tf(x)*td, t\to0$，由此可知$\alpha$的作用是规定步长不能太小，同时也保证下降性
  * $\beta$的作用：$\beta$较大时内部迭代次数较多（用于确定步长的计算量较大），但估计得到的步长较好，外部迭代次数少；较小刚好相反。
* 实际应用时注意检查$x+td$是否在定义域内

## 线性下降方法的收敛性分析

### 通用收敛性证明
* 所谓线性下降，就是误差近似等比地减小
* 每次迭代，下降不小于$\mu||\bigtriangledown f(x)||_2^2$
$$f(x_k)-f(x_{k+1})\geq \mu||\bigtriangledown f(x_k)||_2^2$$
* 第k次迭代，误差$e_k\leq c^ke_0$
$$f(x_k)-p^*=e_k\leq c^ke_0=f(x_0)-p^*$$
这里的c由估计值下界公式算出，$c=1-2m\mu$
* 收敛到误差e，所需步数$K\geq|\frac{log(e_0/e)}{log(1/c)}|=-\frac{log(e_0/e)}{log(c)}$

### 梯度下降+精确直线搜索
* $\mu=\frac{1}{2M}$，由强凸性易证
$c=1-m/M$
* 收敛到误差e，所需步数$K\geq|\frac{log(e_0/e)}{log(1/c)}|$
* 步长$K$估计值$\frac{log(e_0/e)}{-log(1-m/M)}\to\frac{log(e_0/e)}{m/M}$，故收敛步数大约正比于M/m，即收敛速度很强地线性依赖于M/m

### 梯度下降+回溯直线搜索
* $\forall t\leq\frac{1}{M}$满足回溯停止条件
因此，每一步回溯直线搜索要么t=1，要么$t\geq\frac{\beta}{M}$
* $\mu=\alpha\ min(1,\frac{\beta}{M})$，由回溯终止条件直接指出的
$c=1-2m\alpha\ min(1,\frac{\beta}{M})$
* 步数大约正比于M/m(收敛速度很强地线性依赖于M/m)

### 最速下降+精确直线搜索
* 约束/参数：原范数，对偶范数至少是2范数的$\gamma$，$\tilde{\gamma}$倍
  $||\cdot||\geq\gamma||\cdot||_2$,$||\cdot||_*\geq\tilde{\gamma}||\cdot||_2$
* $\mu=\frac{1}{2M}$，爆算+针对2范数合理放缩（见作业）
计算结果和梯度+精确一样，过程却有所不同，很有意思
$c=1-m/M$
  
### 最速下降+回溯直线搜索
* 参数：$\gamma$，$\tilde{\gamma}$
* 估计步长：$t\leq\frac{\gamma^2}{M}$时回溯停止条件满足，每步收敛步长$t\geq min(1,\beta\frac{\gamma^2}{M})$
* $\mu=\alpha\tilde{\gamma}^2min(1,\frac{\beta\gamma^2}{M})$，步骤和梯度+回溯完全对应，针对2范数有一个系数放缩
* $c=1-2m\alpha\tilde{\gamma}^2min(1,\frac{\beta\gamma^2}{M})$

## 非线性下降方法（牛顿方法+回溯直线搜索）
* 下降方向
$d_{nt}=-\bigtriangledown^2f(x)^{-1}\bigtriangledown f(x)$
意义：二阶泰勒展开最小值/Hessian矩阵范数
下降性证明：因为二阶梯度是正定的，所以$\bigtriangledown^Tf(x)d_{nt}=-\bigtriangledown^Tf(x)\bigtriangledown^2f(x)^{-1}\bigtriangledown f(x)<0$
* 牛顿减小量
$\lambda=(\bigtriangledown^Tf(x)\bigtriangledown^2f(x)^{-1}\bigtriangledown f(x))^{1/2}$
$\lambda^2=d_{nt}^T\bigtriangledown ^2f(x)d_{nt}$,$\lambda^2=-\bigtriangledown^Tf(x)d_{nt}$
迭代停止：$\lambda^2<e$
* 回溯直线搜索
回溯停止条件：$f(x+td_{nt})<f(x)-\alpha t\lambda^2$
实际上$\lambda^2=-\bigtriangledown^Tf(x)d_{nt}$,停止条件和之前的回溯直线搜索是对应的。
* 收敛性分析（具体看作业）
  * 前提：F范数（方均根范数，Frobenius范数）Lipschitz连续
  $$||\bigtriangledown^2f(x)-\bigtriangledown^2f(x_0)||_F<L||x-x_0||_2$$
  L可以解释为三阶导数的界，在L较小时牛顿法表现较好
  * 阻尼牛顿：存在$0<\eta\leq\frac{m^2}{L}$使得
  在$||\bigtriangledown f(x)||_2>\eta$时,每次至少下降$\gamma$
  证明思路：固定$\eta$并正常估计步长，计算每一步下降量来估计$\gamma=\alpha\beta\eta^2\frac{m}{M^2}$
  * 二次收敛：在$||\bigtriangledown f(x)||_2<\eta$,每一步都有$||\bigtriangledown f(x_{k+1})||_2<\frac{L}{2m^2}||\bigtriangledown f(x_{k})||_2^2$
  证明思路：证明步长为1（利用L，梯度差换变量形成二阶导，函数积分2次），爆算估计$\eta=min(1,3(1-2\alpha))\frac{m^2}{L}$，顺便证明了二次收敛性