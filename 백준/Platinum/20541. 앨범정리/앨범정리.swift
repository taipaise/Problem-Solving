import Foundation

// 앨범 삭제 추가
// 앨범 안에 앨범이 들어갈 수 있음. 디렉터리 구조
// 앨범 삭제 시 재귀적으로 하위 앨범들까지 모두 삭제해주어야 함
// 사진 삭제 추가
// 현재 앨범 이동

struct Heap<T: Comparable> {
    private var heap: [T?] = [nil]
    private let compare: (T, T) -> Bool
    var count: Int {
        return heap.count - 1
    }
    var peek: T? {
        guard !isEmpty else { return nil }
        return heap[1]
    }
    var isEmpty: Bool {
        return heap.count <= 1
    }

    init(compare: @escaping (T, T) -> Bool) {
        self.compare = compare
    }

    mutating func insert(_ element: T) {
        heap.append(element)
        heapifyUp()
    }

    mutating func pop() -> T? {
        guard !isEmpty else { return nil }
        heap.swapAt(1, heap.count - 1)
        defer { heapifyDown() }
        return heap.removeLast()
    }

    private mutating func heapifyUp() {
        var index = heap.count - 1

        while
            index > 1,
            let child = heap[index],
            let parent = heap[index / 2],
            compare(child, parent)
        {
            heap.swapAt(index, index / 2)
            index /= 2
        }
    }

    private mutating func heapifyDown() {
        var index = 1

        while index * 2 < heap.count {
            var candidateIndex = index * 2

            if
                candidateIndex + 1 < heap.count,
                let left = heap[candidateIndex],
                let right = heap[candidateIndex + 1],
                compare(right, left)
            { candidateIndex += 1 }

            guard
                let parent = heap[index],
                let child = heap[candidateIndex],
                compare(child, parent)
            else { return }

            heap.swapAt(index, candidateIndex)
            index = candidateIndex
        }
    }
}

enum CommandType: String {
    case makeAlbum = "mkalb" // 앨범 생성 실패 시 안내 메시지 출력. 동일 이름 앨범 생성 x
    case removeAlbum = "rmalb" // 삭제된 앨범 개수과 사진 개수 출력
    case insertPhoto = "insert" // 사진 추가 실패 시 안내 메시지 출력. 동일 이름 사진 생성 x
    case deletePhoto = "delete" // 삭제된 사진의 개수 출력
    case changeAlbum = "ca" // 이동한 후 현재 앨범 이름 출력
}

final class Album: Hashable, Comparable {
    typealias Photo = String
    let name: String
    var childs: [String: Album]
    var photos: Set<Photo>
    weak var parent: Album?
    private var maxAlbumNames = Heap<String>(compare: >)
    private var minAlbumNames = Heap<String>(compare: <)
    private var maxPhotoNames = Heap<String>(compare: >)
    private var minPhotoNames = Heap<String>(compare: <)

    init(_ name: String, _ parent: Album?) {
        self.name = name
        self.parent = parent
        childs = [:]
        photos = []
    }

    convenience init(_ name: String) {
        self.init(name, nil)
    }

    // MARK: - 앨범 생성 함수들
    func makeAlbum(_ name: String) -> String {
        guard childs[name] == nil else { return "duplicated album name\n" }

        let newAlbum = Album(name, self)
        childs[name] = newAlbum
        maxAlbumNames.insert(name)
        minAlbumNames.insert(name)
        return ""
    }

    // MARK: - 앨범 삭제 함수들
    func removeAlbum(_ detail: String) -> String {
        var deletedAlbumCount = 0
        var deletedPhotoCount = 0

        if let deleteType = DeleteType(rawValue: detail) {
            switch deleteType {
            case .asc:
                guard
                    let albumName = minAlbumName(),
                    let album = childs[albumName]
                else { break }

                // album의 하위 앨범 재귀적 삭제
                (deletedAlbumCount, deletedPhotoCount) = album.removeAll()
                // 특정 album 삭제, 특정 album의 사진 삭제
                deletedAlbumCount += 1
                deletedPhotoCount += album.photos.count
                childs[albumName] = nil
            case .desc:
                guard
                    let albumName = maxAlbumName(),
                    let album = childs[albumName]
                else { break }

                // 특정 album의 하위 앨범 재귀적 삭제
                (deletedAlbumCount, deletedPhotoCount) = album.removeAll()
                // 특정 album 삭제, 특정 album의 사진 삭제
                deletedAlbumCount += 1
                deletedPhotoCount += album.photos.count
                childs[albumName] = nil
            case .all:
                // 현재 앨범의 하위 앨범들, 하위 사진들 전체 삭제
                (deletedAlbumCount, deletedPhotoCount) = removeAll()
                childs = [:]
            }
        } else { // 특정 이름 가진 앨범 삭제
            if let album = childs[detail] {
                // 하위 앨범들 삭제
                (deletedAlbumCount, deletedPhotoCount) = album.removeAll()
                // 특정 이름 가진 앨범, 앨범의 사진 삭제
                deletedAlbumCount += 1
                deletedPhotoCount += album.photos.count
                childs[detail] = nil
            }
        }
        return "\(deletedAlbumCount) \(deletedPhotoCount)\n"
    }

    // 하위 앨범 재귀적으로 전체 삭제. 현재 앨범 삭제 x, 현재 앨범의 사진 삭제 x
    private func removeAll() -> (albumCount: Int, photoCount: Int) {
        var deletedAlbumCount = childs.count
        var deletedPhotoCount = 0

        for child in childs.values {
            deletedPhotoCount += child.photos.count
            let (albumCount, photoCount) = child.removeAll()
            deletedAlbumCount += albumCount
            deletedPhotoCount += photoCount
        }

        childs = [:]
        return (deletedAlbumCount, deletedPhotoCount)
    }

    private func maxAlbumName() -> String? {
        while let name = maxAlbumNames.pop() {
            guard childs[name] != nil else { continue }
            return name
        }

        return nil
    }

    private func minAlbumName() -> String? {
        while let name = minAlbumNames.pop() {
            guard childs[name] != nil else { continue }
            return name
        }

        return nil
    }

    // MARK: - 사진 추가
    func insertPhoto(_ name: String) -> String {
        guard !photos.contains(name) else {
            return "duplicated photo name\n"
        }

        maxPhotoNames.insert(name)
        minPhotoNames.insert(name)
        photos.insert(name)
        return ""
    }

    // MARK: - 사진 삭제
    func deletePhoto(_ detail: String) -> String {
        var deletedPhotoCount = 0

        if let deleteType = DeleteType(rawValue: detail) {
            switch deleteType {
            case .asc:
                guard let photo = minPhotoName() else { break }
                deletedPhotoCount = 1
                photos.remove(photo)
            case .desc:
                guard let photo = maxPhotoName() else { break }
                deletedPhotoCount = 1
                photos.remove(photo)
            case .all:
                deletedPhotoCount = photos.count
                photos = []
                maxPhotoNames = Heap<String>(compare: >)
                minPhotoNames = Heap<String>(compare: <)
            }
        } else { // 특정 이름 가진 사진 삭제
            if let photo = photos.first(where: {$0 == detail} ) {
                deletedPhotoCount = 1
                photos.remove(photo)
            }
        }

        return "\(deletedPhotoCount)\n"
    }

    private func maxPhotoName() -> String? {
        while let name = maxPhotoNames.pop() {
            guard photos.contains(name) else { continue }
            return name
        }

        return nil
    }

    private func minPhotoName() -> String? {
        while let name = minPhotoNames.pop() {
            guard photos.contains(name) else { continue }
            return name
        }

        return nil
    }

    // MARK: - 앨범 이동함수
    func changeAlbum(_ detail: String) -> Album {
        if let changeType = ChangeAlbumType(rawValue: detail) {
            switch changeType {
            case .up:
                // 상위 앨범 이동
                if let parent = parent {
                    return parent
                } else {
                    return self
                }
            case .root:
                // 루트로 이동
                var curAlbum = self
                while let parent = curAlbum.parent {
                    curAlbum = parent
                }
                return curAlbum
            }
        } else {
            // 하위의 특정 이름을 가진 앨범으로 이동
            if let album = childs[detail] {
                return album
            } else {
                return self
            }
        }
    }

    // MARK: - 해시, 비교 함수
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    static func ==(_ lhs: Album, _ rhs: Album) -> Bool {
        return lhs.name == rhs.name
    }

    static func <(_ lhs: Album, _ rhs: Album) -> Bool {
        return lhs.name < rhs.name
    }
}

extension Album {
    enum ChangeAlbumType: String {
        case up = ".."
        case root = "/"
    }

    enum DeleteType: String {
        case asc = "-1"
        case desc = "1"
        case all = "0"
    }
}

let io = FileIO()
let n = io.readInt()
var curAlbum = Album("album")
var iniAlbum = curAlbum
var res = ""

for _ in 0..<n {
    let commandType = CommandType(rawValue: io.readString())!
    let detail = io.readString()

    switch commandType {
    case .makeAlbum:
        res += curAlbum.makeAlbum(detail)
    case .removeAlbum:
        res += curAlbum.removeAlbum(detail)
    case .insertPhoto:
        res += curAlbum.insertPhoto(detail)
    case .deletePhoto:
        res += curAlbum.deletePhoto(detail)
    case .changeAlbum:
        curAlbum = curAlbum.changeAlbum(detail)
        res += "\(curAlbum.name)\n"
    }
}
print(res)


final class FileIO {
    private var buffer:[UInt8]
    private var index: Int

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        buffer = Array(fileHandle.readDataToEndOfFile())+[UInt8(0)]
        index = 0
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

        return buffer.withUnsafeBufferPointer { $0[index] }
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10 || now == 32 { now = read() }
        if now == 45{ isPositive.toggle(); now = read() }
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }

        return sum * (isPositive ? 1:-1)
    }

    @inline(__always) func readString() -> String {
        var str = ""
        var now = read()

        while now == 10
                || now == 32 { now = read() }

        while now != 10
                && now != 32 && now != 0 {
            str += String(bytes: [now], encoding: .ascii)!
            now = read()
        }

        return str
    }
}
