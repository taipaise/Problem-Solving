# [Platinum IV] 더블 초콜릿 - 25797 

[문제 링크](https://www.acmicpc.net/problem/25797) 

### 성능 요약

메모리: 79548 KB, 시간: 12 ms

### 분류

그래프 이론, 그래프 탐색, 구현

### 제출 일자

2025년 3월 17일 00:13:56

### 문제 설명

<p>Double Chocolate (또는 Double Choco)는 격자 위에서 이루어지는 퍼즐의 일종이다. 일부 칸은 흰색으로, 나머지는 회색으로 칠해져 있으며, 몇몇 칸에는 1 이상의 정수가 쓰여 있다. 플레이어는 퍼즐 전체를 다음의 규칙에 따라 1개 이상의 영역으로 나누어야 한다.</p>

<ul>
	<li>하나의 영역 안에는 상하좌우로 연결된 흰색 칸의 영역과 회색 칸의 영역이 하나씩 있어야 하며, 이 두 영역의 모양은 동일해야 한다. 가로, 세로, 또는 대각선으로 뒤집거나 회전한 모양은 같은 모양이다.</li>
	<li>하나의 영역 안에는 정수가 쓰여 있는 칸을 최대 1개만 포함할 수 있으며, 그러한 칸이 있을 경우 그 영역의 각 색깔의 면적이 해당 정수와 같아야 한다.</li>
	<li>같은 영역에 포함된 두 칸 사이에 불필요한 경계선이 그려져 있지 않아야 한다.</li>
</ul>

<p>다음은 더블 초콜릿 문제와 정답의 예시이다.</p>

<p style="text-align: center;"><img alt="" src="https://upload.acmicpc.net/7aacc574-2782-4a08-92e4-09f07bad89c2/-/preview/"></p>

<p>다음은 오답의 예시이다.</p>

<p style="text-align: center;"><img alt="" src="https://upload.acmicpc.net/57a980fd-32c3-4d08-b3da-9591048e42e3/-/preview/"></p>

<ul>
	<li>영역의 흰색과 회색의 넓이가 영역 내의 수와 일치하지 않음, 한 영역 내에 수가 2개 이상 있음</li>
	<li>하나의 영역에 흰색 영역만 있거나 회색 영역만 있음</li>
	<li>하나의 영역 내에서 흰색 영역끼리, 회색 영역끼리 연결되어 있지 않음</li>
	<li>같은 영역에 속한 칸 사이에 불필요한 경계선이 있음</li>
	<li>같은 영역에 속한 흰색 영역과 회색 영역의 모양이 일치하지 않음</li>
</ul>

<p>더블 초콜릿 문제와 답이 주어졌을 때, 정답이 맞는지 체크해보자.</p>

### 입력 

 <p>첫 줄에 격자의 크기를 나타내는 정수 <mjx-container class="MathJax" jax="CHTML" style="font-size: 109%; position: relative;"><mjx-math class="MJX-TEX" aria-hidden="true"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D441 TEX-I"></mjx-c></mjx-mi></mjx-math><mjx-assistive-mml unselectable="on" display="inline"><math xmlns="http://www.w3.org/1998/Math/MathML"><mi>N</mi></math></mjx-assistive-mml><span aria-hidden="true" class="no-mathjax mjx-copytext">$N$</span></mjx-container>이 주어진다.</p>

<p>다음 줄부터는 더블 초콜릿 문제가 주어진다. 첫 <mjx-container class="MathJax" jax="CHTML" style="font-size: 109%; position: relative;"><mjx-math class="MJX-TEX" aria-hidden="true"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D441 TEX-I"></mjx-c></mjx-mi></mjx-math><mjx-assistive-mml unselectable="on" display="inline"><math xmlns="http://www.w3.org/1998/Math/MathML"><mi>N</mi></math></mjx-assistive-mml><span aria-hidden="true" class="no-mathjax mjx-copytext">$N$</span></mjx-container>개 줄에는 문제의 각 칸이 어떤 색인지 1(회색) 또는 0(흰색)으로 주어진다. 그 다음 줄에는 문제에 쓰여 있는 정수의 개수 <mjx-container class="MathJax" jax="CHTML" style="font-size: 109%; position: relative;"><mjx-math class="MJX-TEX" aria-hidden="true"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D43E TEX-I"></mjx-c></mjx-mi></mjx-math><mjx-assistive-mml unselectable="on" display="inline"><math xmlns="http://www.w3.org/1998/Math/MathML"><mi>K</mi></math></mjx-assistive-mml><span aria-hidden="true" class="no-mathjax mjx-copytext">$K$</span></mjx-container>가 주어지고, 그 다음 <mjx-container class="MathJax" jax="CHTML" style="font-size: 109%; position: relative;"><mjx-math class="MJX-TEX" aria-hidden="true"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D43E TEX-I"></mjx-c></mjx-mi></mjx-math><mjx-assistive-mml unselectable="on" display="inline"><math xmlns="http://www.w3.org/1998/Math/MathML"><mi>K</mi></math></mjx-assistive-mml><span aria-hidden="true" class="no-mathjax mjx-copytext">$K$</span></mjx-container>줄에는 각 줄마다 정수가 쓰여 있는 좌표 <mjx-container class="MathJax" jax="CHTML" style="font-size: 109%; position: relative;"><mjx-math class="MJX-TEX" aria-hidden="true"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D45F TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n"><mjx-c class="mjx-c2C"></mjx-c></mjx-mo><mjx-mi class="mjx-i" space="2"><mjx-c class="mjx-c1D450 TEX-I"></mjx-c></mjx-mi></mjx-math><mjx-assistive-mml unselectable="on" display="inline"><math xmlns="http://www.w3.org/1998/Math/MathML"><mi>r</mi><mo>,</mo><mi>c</mi></math></mjx-assistive-mml><span aria-hidden="true" class="no-mathjax mjx-copytext">$r, c$</span></mjx-container> (행 번호, 열 번호)와 그 칸에 쓰여 있는 정수 <mjx-container class="MathJax" jax="CHTML" style="font-size: 109%; position: relative;"><mjx-math class="MJX-TEX" aria-hidden="true"><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D458 TEX-I"></mjx-c></mjx-mi></mjx-math><mjx-assistive-mml unselectable="on" display="inline"><math xmlns="http://www.w3.org/1998/Math/MathML"><mi>k</mi></math></mjx-assistive-mml><span aria-hidden="true" class="no-mathjax mjx-copytext">$k$</span></mjx-container>가 순서대로 주어진다. 맨 왼쪽 위 칸의 좌표는 1행 1열이고, 주어지는 좌표에 중복된 좌표는 없다. 주어진 더블 초콜릿 문제는 정답이 0개, 1개, 또는 여러 개일 수 있다.</p>

<p>그 다음 줄부터는 해당 문제에 대한 답이 주어진다. 답은 <mjx-container class="MathJax" jax="CHTML" style="font-size: 109%; position: relative;"><mjx-math class="MJX-TEX" aria-hidden="true"><mjx-mo class="mjx-n"><mjx-c class="mjx-c28"></mjx-c></mjx-mo><mjx-mn class="mjx-n"><mjx-c class="mjx-c32"></mjx-c></mjx-mn><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D441 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n" space="3"><mjx-c class="mjx-c2B"></mjx-c></mjx-mo><mjx-mn class="mjx-n" space="3"><mjx-c class="mjx-c31"></mjx-c></mjx-mn><mjx-mo class="mjx-n"><mjx-c class="mjx-c29"></mjx-c></mjx-mo><mjx-mo class="mjx-n" space="3"><mjx-c class="mjx-cD7"></mjx-c></mjx-mo><mjx-mo class="mjx-n" space="3"><mjx-c class="mjx-c28"></mjx-c></mjx-mo><mjx-mn class="mjx-n"><mjx-c class="mjx-c32"></mjx-c></mjx-mn><mjx-mi class="mjx-i"><mjx-c class="mjx-c1D441 TEX-I"></mjx-c></mjx-mi><mjx-mo class="mjx-n" space="3"><mjx-c class="mjx-c2B"></mjx-c></mjx-mo><mjx-mn class="mjx-n" space="3"><mjx-c class="mjx-c31"></mjx-c></mjx-mn><mjx-mo class="mjx-n"><mjx-c class="mjx-c29"></mjx-c></mjx-mo></mjx-math><mjx-assistive-mml unselectable="on" display="inline"><math xmlns="http://www.w3.org/1998/Math/MathML"><mo stretchy="false">(</mo><mn>2</mn><mi>N</mi><mo>+</mo><mn>1</mn><mo stretchy="false">)</mo><mo>×</mo><mo stretchy="false">(</mo><mn>2</mn><mi>N</mi><mo>+</mo><mn>1</mn><mo stretchy="false">)</mo></math></mjx-assistive-mml><span aria-hidden="true" class="no-mathjax mjx-copytext">$(2N+1) \times (2N+1)$</span></mjx-container> 크기의 아스키 아트 형태로 주어지며, 주어진 문제를 영역으로 나누는 방법에 대한 정보만을 포함한다. 이 그림은 다음의 조건을 만족한다.</p>

<ul>
	<li>홀수 번째 줄 홀수 번째 글자는 각 정사각형 칸의 꼭지점을 나타내며, 모두 <code>+</code>이다.</li>
	<li>짝수 번째 줄 짝수 번째 글자는 각 정사각형 칸의 내부를 나타내며, 모두 <code>.</code>이다.</li>
	<li>홀수 번째 줄 짝수 번째 글자는 가로 경계선을 나타내며, 그 자리에 경계선이 있으면 <code>-</code>, 없으면 <code>.</code>이다. 첫 번째 줄과 마지막 줄의 짝수 번째 글자는 모두 <code>-</code>이다.</li>
	<li>짝수 번째 줄 홀수 번째 글자는 세로 경계선을 나타내며, 그 자리에 경계선이 있으면 <code>|</code>, 없으면 <code>.</code>이다. 짝수 번째 줄의 첫 번째와 마지막 글자는 모두 <code>|</code>이다.</li>
</ul>

### 출력 

 <p>주어진 답이 주어진 문제에 대한 정답이 맞다면 1, 아니면 0을 출력한다.</p>

