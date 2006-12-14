local L = AceLibrary("AceLocale-2.2"):new("Grid")

local strings_koKR = {
	--{{{ GridCore
	["Debugging"] = "디버깅",
	["Module debugging menu."] = "디버깅 메뉴 모듈",
	["Debug"] = "디버그",
	["Toggle debugging for %s."] = "%s을 위해 디버깅 토글",
	
	--}}}
	--{{{ GridFrame
	["Frame"] = "프레임",
	["Options for GridFrame."] = "GridFrame을 위한 옵션",

	["Show Tooltip"] = "툴팁 표시",
	["Show unit tooltip.  Choose 'Always', 'Never', or 'OOC'."] = "유닛 툴팁을 표시합니다. '항상', '안함' 또는 'OCC'를 선택합니다",
	["Always"] = "항상",
	["Never"] = "안함",
	["OOC"] = "OOC",
	["Center Text Length"] = "중앙 글꼴 길이",
	["Number of characters to show on Center Text indicator."] = "중앙 글꼴 표준을 표시를 위한 캐릭터의 숫자를 표시합니다.",
	["Invert Bar Color"] = "거꾸로 바 색상",
	["Swap foreground/background colors on bars."] = "전경/배경 바의 색상을 전환합니다.",

	["Indicators"] = "표준",
	["Border"] = "테두리",
	["Health Bar"] = "체력바",
	["Center Text"] = "중앙 글꼴",
	["Center Text 2"] = "중앙 글꼴 2",
	["Center Icon"] = "중앙 아이콘",
	["Top Left Corner"] = "왼쪽 상단 모서리",
	["Top Right Corner"] = "오른쪽 상단 모서리",
	["Bottom Left Corner"] = "왼쪽 하단 모서리",
	["Bottom Right Corner"] = "오른쪽 하단 모서리",
	["Frame Alpha"] = "프레임 투명도",

	["Options for %s indicator."] = "%s 표준 옵션",
	["Statuses"] = "상태",
	["Toggle status display."] = "상태 표시 토글",

	-- Advanced options
	["Advanced"] = "고급",
	["Advanced options."] = "고급 옵션",
	["Enable %s indicator"] = "%s 표준 활성화",
	["Toggle the %s indicator."] = "%s 표준 토글",
	["Frame Width"] = "프레임 넓이",
	["Adjust the width of each unit's frame."] = "각 유닛 프레임의 넓이를 조정합니다.",
	["Frame Height"] = "프레임 높이",
	["Adjust the height of each unit's frame."] = "각 유닛 프레임의 높이를 조정합니다.",
	["Corner Size"] = "모퉁이 크기",
	["Adjust the size of the corner indicators."] = "모퉁이 표준 크기를 조정합니다.",
	["Font Size"] = "글꼴 크기",
	["Adjust the font size."] = "글꼴 크기를 조정합니다.",
	["Orientation"] = "오리엔테이션",
	["Set frame orientation."] = "오리엔테이션 프레임을 설정합니다.",
	["Icon Size"] = "아이콘 크기",
	["Adjust the size of the center icon."] = "중앙 아이콘의 크기를 조정합니다.",

	--}}}
	--{{{ GridLayout
	["Layout"] = "배치",
	["Options for GridLayout."] = "GridLayout 옵션",

	-- Layout options
	["Show Frame"] = "프레임 표시",
	["Sets when the Grid is visible: Choose 'Always', 'Grouped', or 'Raid'."] = "Grid 표시 세트: '항상', '파티' 또는 '공격대'를 선택합니다.",
	["Always"] = "항상",
	["Grouped"] = "파티",
	["Raid"] = "공격대",
	["Raid Layout"] = "공격대 배치",
	["Select which raid layout to use."] = "사용할 공격대 배치를 선택합니다.",
	["Show Party in Raid"] = "공격대의 파티를 표시합니다.",
	["Show party/self as an extra group."] = "그룹에서 파티/자기를 표시합니다.",
	["Horizontal groups"] = "수평 그룹",
	["Switch between horzontal/vertical groups."] = "그룹을 수평/수직으로 전환합니다.",
	["Frame lock"] = "프레임 고정",
	["Locks/unlocks the grid for movement."] = "Grid 프레임의 위치를 고정시키거나 이동시킵니다.",

	-- Display options
	["Padding"] = "패딩",
	["Adjust frame padding."] = "프레임 패딩을 조정합니다.",
	["Spacing"] = "간격",
	["Adjust frame spacing."] = "프레임 간격을 조정합니다.",
	["Scale"] = "크기",
	["Adjust Grid scale."] = "Grid 크기를 조정합니다.",
	["Border"] = "테두리",
	["Adjust border color and alpha."] = "테두리 색상 그리고 투명도를 조정합니다.",
	["Background"] = "배경",
	["Adjust background color and alpha."] = "배경 색상 그리고 투명도를 조정합니다.",

	-- Advanced options
	["Advanced"] = "고급",
	["Advanced options."] = "고급 옵션",
	["Layout Anchor"] = "레이아웃 앵커",
	["Sets where Grid is anchored relative to the screen."] = "Grid 스크린 앵커를 설정합니다.",
	["Group Anchor"] = "그룹 앵커",
	["Sets where groups are anchored relative to the layout frame."] = "그룹의 레이아웃 프레임의 앵커를 설정합니다.",
	["Reset Position"] = "위치 초기화",
	["Resets the layout frame's position and anchor."] = "레이아웃 프레임의 위치와 앵커를 초기화 합니다.",

	--}}}
	--{{{ GridLayoutLayouts
	["None"] = "없음",
	["By Group 40"] = "그룹 40",
	["By Group 25"] = "그룹 25",
	["By Group 20"] = "그룹 20",
	["By Group 15"] = "그룹 15",
	["By Group 10"] = "그룹 10",
	["By Class"] = "직업",
	["Onyxia"] = "오닉시아",
	
	--}}}
	--{{{ GridRange
	-- used for getting spell range from tooltip
	["(%d+) yd range"] = "(%d+)미터",

	--}}}
	--{{{ GridStatus
	["Status"] = "상태",
	["Options for %s."] = "%s 옵션",

	-- module prototype
	["Status: %s"] = "상태: %s",
	["Color"] = "색상",
	["Color for %s"] = "%s 색상",
	["Priority"] = "우선 순위",
	["Priority for %s"] = "%s 우선 순위",
	["Range filter"] = "범위 필터",
	["Range filter for %s"] = "%s 범위 필터",
	["Enable"] = "활성화",
	["Enable %s"] = "%s 활성화",
	
	--}}}
	--{{{ GridStatusAggro
	["Aggro"] = "어그로",
	["Aggro alert"] = "어그로 경고",
	
	--}}}
	--{{{ GridStatusAuras
	["Debuff type: %s"] = "디버프 형식: %s",
	["Poison"] = "독",
	["Disease"] = "질병",
	["Magic"] = "마법",
	["Curse"] = "저주",
	["Add new Buff"] = "새로운 버프 추가",
	["Adds a new buff to the status module"] = "상태 모듈에 새로운 버프를 추가합니다.",
	["Add new Debuff"] = "새로운 디버프 추가",
	["Adds a new debuff to the status module"] = "상태 모듈에 새로운 디버프를 추가합니다.",
	["Delete (De)buff"] = "(디)버프 삭제",
	["Deletes an existing debuff from the status module"] = "기존의 디버프 상태 모듈을 삭제합니다.",
	["Remove %s from the menu"] = "메뉴에서 %s|1을;를; 제거합니다.",
	["Debuff: %s"] = "디버프: %s",
	["Buff: %s"] = "버프: %s",
	["Class Filter"] = "직업 필터",
	["Show status for the selected classes."] = "선택된 직업의 상태를 표시합니다.",
	["Show on %s."] = "%s 표시",

	--}}}
	--{{{ GridStatusName
	["Unit Name"] = "유닛 이름",
	["Color by class"] = "직업 색상",
	
	--}}}
	--{{{ GridStatusMana
	["Mana threshold"] = "마나 값",
	["Set the percentage for the low mana warning."] = "낮은 마나 경고를 위한 백분율을 설정합니다.",
	["Low Mana warning"] = "마나 낮음 경고",
	["Low Mana"] = "마나 낮음",
	
	--}}}
	--{{{ GridStatusHeals
	["Heals"] = "치유",
	["Incoming heals"] = "들어오는 치유",
	["(.+) begins to cast (.+)."] = "(.+)|1이;가; (.+)|1을;를; 시전합니다.",
	["(.+) gains (.+) Mana from (.+)'s Life Tap."] = "(.+)|1이;가; 생명력 전환|1으로;로; (.+)의 (.+)|1을;를; 얻었습니다.",
	["^Corpse of (.+)$"] = "(.+)|1이;가; 죽었습니다.",
	
	--}}}
	--{{{ GridStatusHealth
	["Unit health"] = "유닛 체력",
	["Health deficit"] = "결손 체력",
	["Low HP warning"] = "체력 낮음 경고",
	["Death warning"] = "죽음 경고",
	["Offline warning"] = "오프라인 경고",
	["Health"] = "체력",
	["Show dead as full health"] = "죽은후 모든 체력 표시",
	["Treat dead units as being full health."] = "죽은 유닛의 체력을 모두 표시합니다.",
	["Use class color"] = "직업 색상 사용",
	["Color health based on class."] = "직업 체력 색상",
	["Health threshold"] = "체력 값",
	["Only show deficit above % damage."] = "백분율(%) 데미지의 결손량 표시",
	["Color deficit based on class."] = "직업별 결손량 색상",
	["Low HP threshold"] = "낮음 체력 값",
	["Set the HP % for the low HP warning."] = "낮은 체력 경고를 위한 백분율(%)을 설정합니다.",

	--}}}
	--{{{ GridStatusRange
	["Range check frequency"] = "범위 체크 빈도",
	["Seconds between range checks"] = "범위 체크 초 설정",
	["Out of Range"] = "목표가 사정 거리를 벗어났습니다.",

	--}}}
	--{{{ GridStatusTarget
	["Your Target"] = "당신의 타겟",

	--}}}
}

L:RegisterTranslations("koKR", function() return strings_koKR end)
