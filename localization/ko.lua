--[[
	Korean Localization
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'koKR')
if not L then return end

-- main
L.AddWaypoint = '경로 추가'
L.AskForfeit = '업그레이드가 없습니다. 전투를 종료하시겠습니까?'
L.AvailableBreeds = '가능한 품종'
L.Breed = '품종'
L.BreedExplanation = '레벨이 올라갈 때 각 통계가 어떻게 분배되는지를 결정합니다.'
L.CapturedPets = '포획한 애완동물 보기'
L.CommonSearches = '일반 검색'
L.DisplayCondition = '표시 조건'
L.FilterSpecies = '종 필터'
L.LoadTeam = '팀 불러오기'
L.MissingPets = '누락된 애완동물'
L.MissingRares = '누락된 희귀종'
L.Ninja = '닌자'
L.NoHistory = 'PetTracker가 이 적과의 싸움을 본 적이 없습니다'
L.NoneCollected = '수집된 것 없음'
L.Rivals = '라이벌'
L.ShowJournal = '저널에서 보기'
L.ShowPets = '전투 애완동물 보기'
L.ShowStables = '마구간 보기'
L.Species = '종'
L.StableTip = '|cffffd200여기에서 작은 수수료로 애완동물을|n치료할 수 있습니다.|r'
L.TellMore = '자신에 대해 더 말해 주세요.'
L.UpgradeAlert = '야생 업그레이드가 나타났습니다!'
L.TotalRivals = '총 라이벌 수'
L.ZoneTracker = '지역 추적기'

-- options
L.AlertUpgrades = '업그레이드 경고'
L.AlertUpgradesTip = '비활성화하면 전투 중 업그레이드 알림 상자가 표시되지 않지만, 업그레이드는 여전히 기호로 표시됩니다 (|TInterface/GossipFrame/AvailableQuestIcon:0:0:-1:-2|t).'
L.Forfeit = '포기 여부 묻기'
L.ForfeitTip = '활성화하면 업그레이드가 없는 야생 전투에서 포기할지 여부를 묻습니다.'
L.OptionsDescription = '이 옵션을 사용하면 PetTracker의 일반 기능을 켜고 끌 수 있습니다. 모두 잡아야 합니다!'
L.RivalPortraits = '라이벌 초상화'
L.RivalPortraitsTip = '활성화하면 세계 및 전투 지도에 라이벌이 초상화로 표시됩니다.'
L.SpecieIcons = '종 아이콘'
L.SpecieIconsTip = '활성화하면 세계 및 전투 지도에 애완동물이 유형 대신 종 아이콘으로 표시됩니다.'
L.Switcher = '스위처'
L.SwitcherTip = '활성화하면 전투에서 애완동물을 전환하는 기본 UI가 개선된 UI로 교체됩니다.'
L.ZoneTrackerTip = '활성화하면 현재 지역의 애완동물 포획 진행 상황 목록이 퀘스트 목표 옆에 표시됩니다.|n|n|cff20ff20이 옵션은 애완동물 저널에서 전환할 수도 있습니다.|r'

-- help
L.PatronsDescription = 'PetTracker는 무료로 배포되며 후원을 통해 지원됩니다. Patreon과 Paypal을 통해 개발을 지속적으로 지원해 주시는 모든 후원자분들께 큰 감사를 드립니다. 당신도 |cFFF96854patreon.com/jaliborc|r에서 후원자가 될 수 있습니다.'
L.HelpDescription = '여기에서는 가장 자주 묻는 질문에 대한 답변을 제공합니다. 또한 게임 내 튜토리얼을 따르는 것을 권장합니다. 둘 다 문제를 해결하지 못하면, PetTracker 사용자 커뮤니티에서 도움을 요청할 수 있습니다.'

L.FAQ = {
	'지도에서 모든 애완동물을 표시/숨기려면 어떻게 해야 하나요?',
	'지도의 오른쪽 상단에 있는 돋보기 버튼을 클릭하세요. "애완동물" 아래의 "종"을 클릭하세요.',

	'특정 애완동물만 지도로 표시하려면 어떻게 해야 하나요?',
	'지도의 오른쪽 상단에 있는 돋보기 버튼을 클릭하세요. "종" 아래에 있는 필터 상자를 사용하세요. 일반적인 검색 제안이 표시되며, 자세한 예는 튜토리얼을 참조하세요.',

	'현재 지역의 진행 상황을 표시/숨기려면 어떻게 해야 하나요?',
	'애완동물 도감을 열고 오른쪽 하단의 "지역 추적기"를 클릭하세요.',

	'지역 추적기를 구성하려면 어떻게 해야 하나요?',
	'추적기의 "애완동물" 헤더를 클릭하면 옵션이 나타납니다.',

	'애완동물 전투 중에 적 행동 바를 이동하려면 어떻게 해야 하나요?',
	'Shift 키를 누르고 바를 드래그하세요.',
}

L.Tutorial = {
[[환영합니다! 이제 |cffffd200PetTracker|r를 사용 중입니다, 제작자 |cffffd200Jaliborc|r의 작품입니다.

이 선택적 튜토리얼은 시작하는 데 도움을 줄 것입니다. 그런 다음 진정으로 중요한 일로 돌아갈 수 있습니다: 즉, 모두 잡아야 합니다!]],
[[|cffffd200지역 추적기|r는 현재 지역에서 누락된 애완동물, 그들의 출처, 그리고 잡은 애완동물의 희귀도를 표시합니다.

|A:NPE_LeftClick:14:14|a 헤더 |cffffd200"애완동물"|r을 클릭하여 추가 옵션을 확인하세요.]],
[[|cffffd200세계 지도|r를 열어 PetTracker가 탐험에 어떤 도움을 줄 수 있는지 확인하세요.]],
[[PetTracker는 세계 지도에 애완동물의 가능한 출처를 표시합니다. 또한 마구간과 테이머에 대한 추가 정보를 제공합니다.

이 위치를 필터링하거나 숨기려면, |A:NPE_LeftClick:14:14|a |cffffd200"지도 필터"|r 메뉴를 여세요.]],
[[|cffffd200"종 필터"|r 상자에 입력하여 표시할 애완동물을 필터링할 수 있습니다. 다음은 몇 가지 예입니다:

• |cffffd200고양이|r는 고양이.
• |cffffd200미보유|r는 보유하지 않은 종.
• |cffffd200수중|r는 수중 종.
• |cffffd200퀘스트|r는 퀘스트로 얻을 수 있는 애완동물.
• |cffffd200숲|r는 숲에 서식하는 종.

수학 연산자도 작동합니다:
• |cffffd200< 희귀|r는 희귀 품질의 애완동물이 없는 종.
• |cffffd200< 15|r는 15레벨 이하의 애완동물만 있는 종.]],

[[|cffffd200애완동물 도감|r을 열어 PetTracker가 탐색에 어떤 도움을 줄 수 있는지 확인하세요.]],
[[이 체크박스를 사용하여 |cffffd200지역 추적기|r를 전환할 수 있습니다. 이전에 추적기를 숨겼다면 특히 유용합니다.]],
[[|cffffd200라이벌|r 탭을 열어 이에 대해 더 알아보세요.]],
[[|cffffd200라이벌|r 탭은 다음과 같은 애완동물 전투에 대한 정보를 제공합니다:

• 적 애완동물 및 그들의 능력.
• 일일 퀘스트 및 보상.
• 전투 위치.]],
[[검색 상자에 입력하여 표시할 애완동물을 필터링할 수 있습니다. 다음은 몇 가지 예입니다:

• |cffffd200아키|r는 선택받은 아키.
• |cffffd200용맹|r는 용맹을 보상하는 라이벌.
• |cffffd200드레노어|r는 드레노어에 위치한 라이벌.
• |cffffd200에픽|r는 에픽 희귀도 팀을 가진 라이벌.
• |cffffd200> 20|r는 20레벨 이상의 라이벌.]],
[[PetTracker는 각 라이벌과의 전투를 기록합니다. 전투를 선택하고 |cffffd200팀 로드|r를 클릭하여 이전에 사용한 애완동물을 빠르게 다시 로드하세요.]]
}