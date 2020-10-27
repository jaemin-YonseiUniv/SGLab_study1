코드의 목적
: 학문적 이유를 위해, 스마트그리드 연구실에서 그리드 포밍 발전기를 공부하고자 함.

*********아래의 논문을 참고하여 공부를 진행
*********(Review following paper for academic reason)
D. Pan, X. Wang, F. Liu and R. Shi, "Transient Stability of Voltage-Source Converters With Grid-Forming Control: A Design-Oriented Study," in IEEE Journal of Emerging and Selected Topics in Power Electronics, vol. 8, no. 2, pp. 1019-1033, June 2020, doi: 10.1109/JESTPE.2019.2946310.

사용법
- 매트랩에서 메인 코드를 열고 사용하면 됩니다.

- 메인 코드
1. TransientStability.m

- 함수 또는 서브 코드
1. ang_stable.m
: 그리드 포밍 발전기가 드룹 제어를 할 때 P 루프에만 필터가 있는 경우에, Numerical하게 각도에 대한 미분방정식의 해를 구함

2. ang_stable_both.m
: 그리드 포밍 발전기가 드룹 제어를 할 때 P 루프 / Q 루프 모두에 필터가 있는 경우, Numerical하게 각도에 대한 미분방정식의 해를 구함

3. ang_stable_both_Clear.m (Not function, M code)
: 2번과 유사하지만, CCT 효과를 확인할 수 있도록 수정

4. wofilter.m
: 필터가 없을 때, 발전기 각에 대한 phase plane을 그림

5. wtfilter.m
: P 루프에만 필터가 있을 때, 발전기 각에 대한 phase plane을 그림 ( 델타 - 델타 프라임 - 델타 더블 프라임)

6. ang_init.m
: 초기 값을 구하기 위한 함수이나, 아직 미완의 상태