import Foundation

// BNF는 아래와 같은 문법을 사용한다.
// <기호> ::= <표현식>
// 표현식은 다른 기호의 조합으로 이뤄질 수도 있음
// 표현식과 기호는 |를 이용하여 조합임을 표시한다.
// 기호에는 말단 기호가 올 수 없음 (예: 1, 가)

enum Symbol: String {
    case taunt
    case sentence
    case noun_phrase
    case modified_noun
    case present_rel
    case past_rel
    case present_person
    case past_person
    case noun
    case present_verb
    case past_verb
    case article
    case adjective
    case adverb
    case modifier
}

struct State {
    // 인덱스
    private var taunt = 0
    private var sentence = 0
    private var noun_phrase = 0
    private var modified_noun = 0
    private var present_rel = 0
    private var past_rel = 0
    private var present_person = 0
    private var past_person = 0
    private var noun = 0
    private var present_verb = 0
    private var past_verb = 0
    private var article = 0
    private var adjective = 0
    private var adverb = 0
    private var modifier = 0

    // 선택지 개수
    private let tauntCount = 4
    private let sentenceCount = 3
    private let noun_phraseCount = 1
    private let modified_nounCount = 2
    private let modifierCount = 2
    private let present_relCount = 1
    private let past_relCount = 1
    private let present_personCount = 3
    private let past_personCount = 5
    private let nounCount = 11
    private let present_verbCount = 2
    private let past_verbCount = 2
    private let articleCount = 1
    private let adjectiveCount = 7
    private let adverbCount = 5

    mutating func fetchIndex(_ symbol: Symbol) -> Int {
        var i = 0
        switch symbol {
        case .taunt:
            i = taunt
            taunt = (taunt + 1) % tauntCount
        case .sentence:
            i = sentence
            sentence = (sentence + 1) % sentenceCount
        case .noun_phrase:
            i = noun_phrase
            noun_phrase = (noun_phrase + 1) % noun_phraseCount
        case .modified_noun:
            i = modified_noun
            modified_noun = (modified_noun + 1) % modified_nounCount
        case .present_rel:
            i = present_rel
            present_rel = (present_rel + 1) % present_relCount
        case .past_rel:
            i = past_rel
            past_rel = (past_rel + 1) % past_relCount
        case .present_person:
            i = present_person
            present_person = (present_person + 1) % present_personCount
        case .past_person:
            i = past_person
            past_person = (past_person + 1) % past_personCount
        case .noun:
            i = noun
            noun = (noun + 1) % nounCount
        case .present_verb:
            i = present_verb
            present_verb = (present_verb + 1) % present_verbCount
        case .past_verb:
            i = past_verb
            past_verb = (past_verb + 1) % past_verbCount
        case .article:
            i = article
            article = (article + 1) % articleCount
        case .adjective:
            i = adjective
            adjective = (adjective + 1) % adjectiveCount
        case .adverb:
            i = adverb
            adverb = (adverb + 1) % adverbCount
        case .modifier:
            i = modifier
            modifier = (modifier + 1) % modifierCount
        }
        return i
    }
}

struct Expander {
    private var state = State()

    mutating func fetchTaunt() -> (res: String, tauntCount: Int) {
        var res = ""
        var tauntCount = 1

        switch state.fetchIndex(.taunt) {
        case 0:
            res = fetchSentence()
        case 1:
            let (subRes, subTauntCount) = fetchTaunt()
            tauntCount += subTauntCount
            res = subRes.punctuated + " " + fetchSentence()
        case 2:
            res = fetchNoun() + "!"
        case 3:
            res = fetchSentence()
        default:
            break
        }

        let first = res.first!.uppercased()
        res = first + res.dropFirst()

        return (res.caplitalized, tauntCount)
    }

    mutating func fetchSentence() -> String {
        switch state.fetchIndex(.sentence) {
        case 0:
            return fetchPastRel() + " " + fetchNounPhrase()
        case 1:
            return fetchPresentRel() + " " + fetchNounPhrase()
        case 2:
            return fetchPastRel() + " " + fetchArticle() + " " + fetchNoun()
        default:
            return ""
        }
    }

    mutating func fetchNounPhrase() -> String {
        return fetchArticle() + " " + fetchModifiedNoun()
    }

    mutating func fetchModifiedNoun() -> String {
        switch state.fetchIndex(.modified_noun) {
        case 0:
            return fetchNoun()
        case 1:
            return fetchModifier() + " " + fetchNoun()
        default:
            return fetchNoun()
        }
    }

    mutating func fetchModifier() -> String {
        switch state.fetchIndex(.modifier) {
        case 0:
            return fetchAdjective()
        case 1:
            return fetchAdverb() + " " + fetchAdjective()
        default:
            return fetchAdjective()
        }
    }

    mutating func fetchPresentRel() -> String {
        return "your " + fetchPresentPerson() + " " + fetchPresentVerb()
    }

    mutating func fetchPastRel() -> String {
        return "your " + fetchPastPerson() + " " + fetchPastVerb()
    }

    mutating func fetchPresentPerson() -> String {
        switch state.fetchIndex(.present_person) {
        case 0: return "steed"
        case 1: return "king"
        case 2: return "first-born"
        default: return "steed"
        }
    }

    mutating func fetchPastPerson() -> String {
        switch state.fetchIndex(.past_person) {
        case 0: return "mother"
        case 1: return "father"
        case 2: return "grandmother"
        case 3: return "grandfather"
        case 4: return "godfather"
        default: return "mother"
        }
    }

    mutating func fetchNoun() -> String {
        switch state.fetchIndex(.noun) {
        case 0: return "hamster"
        case 1: return "coconut"
        case 2: return "duck"
        case 3: return "herring"
        case 4: return "newt"
        case 5: return "peril"
        case 6: return "chicken"
        case 7: return "vole"
        case 8: return "parrot"
        case 9: return "mouse"
        case 10: return "twit"
        default: return "hamster"
        }
    }

    mutating func fetchPresentVerb() -> String {
        switch state.fetchIndex(.present_verb) {
        case 0: return "is"
        case 1: return "masquerades as"
        default: return "is"
        }
    }

    mutating func fetchPastVerb() -> String {
        switch state.fetchIndex(.past_verb) {
        case 0: return "was"
        case 1: return "personified"
        default: return "was"
        }
    }

    mutating func fetchArticle() -> String {
        _ = state.fetchIndex(.article)
        return "a"
    }

    mutating func fetchAdjective() -> String {
        switch state.fetchIndex(.adjective) {
        case 0: return "silly"
        case 1: return "wicked"
        case 2: return "sordid"
        case 3: return "naughty"
        case 4: return "repulsive"
        case 5: return "malodorous"
        case 6: return "ill-tempered"
        default: return "silly"
        }
    }

    mutating func fetchAdverb() -> String {
        switch state.fetchIndex(.adverb) {
        case 0: return "conspicuously"
        case 1: return "categorically"
        case 2: return "positively"
        case 3: return "cruelly"
        case 4: return "incontrovertibly"
        default: return "conspicuously"
        }
    }
}

func checkIsHolyGrail(_ input: String) -> Bool {
    let text = "theholygrail"

    var curIndex = text.startIndex

    for char in input {
        if curIndex == text.endIndex { break }
        if text[curIndex] == char {
            curIndex = text.index(after: curIndex)
        }
    }

    return curIndex == text.endIndex
}

func solution() {
    var expander = Expander()

    while let input = readLine() {
        let input = input.normalizeWhitespace

        let wordCount = input
            .split { $0.isWhitespace }
            .filter { $0.rangeOfCharacter(from: .letters) != nil }
            .count

        var answer = "Knight: \(input)\n"
        var needProvocationCount = wordCount / 3
        var provocationCount = 0

        // prefix가 있는지 확인 (the holy grail)
        var hasPrefix = checkIsHolyGrail(input)

        if wordCount % 3 > 0 {
            needProvocationCount += 1
        }

        while provocationCount < needProvocationCount {
            if hasPrefix {
                answer += "Taunter: (A childish hand gesture).\n"
                provocationCount += 1
                hasPrefix = false
                continue
            }

            let (provocation, count) = expander.fetchTaunt()
            provocationCount += count

            answer += "Taunter: \(provocation.punctuated)\n"
        }

        print(answer)
    }
}

solution()

extension String {
    var normalizeWhitespace: String {
        let collapsed = self.replacingOccurrences(
            of: "\\s+",
            with: " ",
            options: .regularExpression)
        return collapsed.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var punctuated: String {
        let t = self.trimmingCharacters(in: .whitespaces)
        guard let last = t.last else { return "." }
        return (last == "." || last == "!" || last == "?") ? t : t + "."
    }

    var caplitalized: String {
        var res = ""
        var shouldCapitalize = true

        for char in self {
            if
                shouldCapitalize,
                char.isLetter
            {
                res.append(String(char).uppercased())
                shouldCapitalize = false
            } else {
                res.append(char)
            }

            if char == "." || char == "!" || char == "?" {
                shouldCapitalize = true
            }
        }

        return res
    }
}