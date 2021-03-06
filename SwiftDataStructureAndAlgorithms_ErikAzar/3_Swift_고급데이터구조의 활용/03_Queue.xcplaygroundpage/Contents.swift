// ํ - Queue
/*
 ๐๐๐บ๐ปโฆ๏ธ
 ๐ด๐ ๐ก๐ข๐ต๐ฃโช๏ธ๐ค
 โโ
 ๐ง 
*/

/*
 ๋จผ์  ์๋ ฅ๋ ๋ฐ์ดํฐ๊ฐ ๋จผ์  ์ถ๋ ฅ๋๋ FIFO(First In First Out)๋ฐ์ดํฐ ๊ตฌ์กฐ๋ฅผ ์ง๋
 
 EX) ์ํผ๋ง์ผ์์ ๊ณ์ฐ์ ์ํด ์ค์ ์  ๊ตฌ๋งค์๋ค๊ณผ ๋น์ทํ ๋ชจ์ต
 ์ค์ ๋งจ ์์ ์  ๊ตฌ๋งค์(head)๊ฐ ๊ณ์ฐ๋์ ๋์ฐฉํ๋ฉด, ๊ณ์ฐ์์ ๊ตฌ๋งคํ ๋ฌผ๊ฑด์ ๊ณ์ฐํ๊ณ  ๊ตฌ๋งค์๋ ๋๊ฐ๋ฅผ ์ง๋ถํ ๋ค
๋ฌผ๊ฑด์ ๋ชจ๋ ๋ด์์๋ ๋ ๋๊ฒ(pop) ๋จ
 ๋ ๋ฒ์งธ ๊ตฌ๋งค์๋ ์ค์ ์ฒซ ๋ฒ์งธ ์์น๋ก ์ด๋ํ๊ณ , ์ฒซ ๋ฒ์งธ ๊ตฌ๋งค์๊ฐ ๊ฑฐ์ณค๋ ๊ณผ์ ์ ๋ฐ๋ณต
 0. โผ๏ธ-> โป๏ธโป๏ธโป๏ธโป๏ธโป๏ธ  (push)
 1.     โผ๏ธโป๏ธโป๏ธโป๏ธโป๏ธ
 2.     โป๏ธโผ๏ธโป๏ธโป๏ธโป๏ธ
 3.     โป๏ธโป๏ธโผ๏ธโป๏ธโป๏ธ
 4.     โป๏ธโป๏ธโป๏ธโผ๏ธโป๏ธ
 5.     โป๏ธโป๏ธโป๏ธโป๏ธโผ๏ธ
 6.     โป๏ธโป๏ธโป๏ธโป๏ธโป๏ธ  (โผ๏ธ-pop)
 7. ์์ ๊ณผ์  ๋ฐ๋ณต
 */

/*
 ๐ด๋ค์ Queue 7 ๋ฉ์๋ ์ ๊ณต๐ด
 enqueue() : ํ์ ๋งจ ๋ค์ ์๋ก์ด ์์๋ฅผ ์ถ๊ฐ
 dequeue() : ํ์์ ์ฒซ ๋ฒ์งธ ์์๋ฅผ ์ ๊ฑฐํ ๋ค ๋ฐํ
 peek() : ํ์ ์ฒซ ๋ฒ์งธ ์์๋ฅผ ๋ฐํํ๋, ์ ๊ฑฐํ์ง๋ ์์
 clear() : ํ๋ฅผ ์ฌ์ค์ ํด ๋น ์ํ๊ฐ ๋๊ฒ ํจ
 count : ํ์ ์๋ ์์์ ์๋ฅผ ๋ฐํ
 isEmpty() : ํ๊ฐ ๋น์ด์์ผ๋ฉด true๋ฅผ ๋ฐํ, ๊ทธ๋ ์ง ์์ ๊ฒฝ์ฐ false๋ฅผ ๋ฐํ
 isFull() : ํ๊ฐ ๊ฝ ์ฐจ์์ผ๋ฉด true ๋ฐํ, ์๋๋ฉด false ๋ฐํ
 
 ๐ก๊ทธ ์ธ ๋์ฐ๋ฏธ ๋ฉ์๋
 capacity : ํ ์ฉ๋์ ๊ฐ์ ธ์ค๊ฑฐ๋ ์ค์ ํ๊ธฐ ์ํ read/write ํ๋กํผํฐ
 insert(_:atIndex) : ํ์ ํน์  ์ธ๋ฑ์ค ์์น์ ์์๋ฅผ ์ฝ์
 removeAtIndex(_) : ํ์ ํน์  ์ธ๋ฑ์ค ์์น์ ์๋ ์์๋ฅผ ์ ๊ฑฐ
 
 */

/*
 ๐ด์์์ ์์ ์ฃผ๋ฌธ ๋ฐ ๊ณ์ฐ์ ์ฌ์ฉํ๋ POS(Point-Of-Sale) ์์คํ์ด ๋ํ์ 
 
 ์ด๋ฒ ํ ๋ฐ์ดํฐ ๊ตฌ์กฐ๋ฅผ ๊ตฌํํ  ๋๋ ์ด๋ค ๋ฐ์ดํฐ ํ์์ด๋  ๋ฐ์๋ค์ผ ์ ์์ ์ ๋๋ก ์ ์ฐํ ์ค์ํํธ '์ ๋๋ฆญ'์ ํ์ฉ ์์ 
 
 */

public struct Queue<T> {
    private var data = [T]()
    // ๋น ํ ๊ตฌ์กฐ๋ฅผ ์ ์
    public init() {}

    // ํ์์ ์ฒซ ๋ฒ์งธ ์์๋ฅผ ์ ๊ฑฐํ๊ณ  ๋ฐํ
    // - ๋ฐํ๊ฐ :
    // - ํ๊ฐ ๋น ์ํ๊ฐ ์๋ ๊ฒฝ์ฐ, ์ฒซ ๋ฒ์งธ ์์์ ํ์์ 'T'
    // - ํ๊ฐ ๋น ์ํ์ธ ๊ฒฝ์ฐ, 'nil'์ ๋ฐํ
    public mutating func dequeue() -> T? {
        return data.removeFirst()
    }
    
    // ํ์์ ์ฒซ ๋ฒ์งธ ์์๋ฅผ ์ ๊ฑฐํ์ง ์๊ณ  ๋ฐํ
    // - ๋ฐํ๊ฐ :
    // - ํ๊ฐ ๋น ์ํ๊ฐ ์๋ ๊ฒฝ์ฐ, ์ฒซ ๋ฒ์งธ ์์์ ํ์์ 'T'
    // - ํ๊ฐ ๋น ์ํ์ธ ๊ฒฝ์ฐ, 'nil'์ ๋ฐํ
    public func peek() -> T? {
        return data.first
    }
    
    // ํ์ ๋งจ ๋ค์ ์์๋ฅผ ์ถ๊ฐ
    // - ๋ณต์ก์ฑ : O(1)
    // - ํ๋ผ๋ฏธํฐ ์์ : 'T' ํ์์ ์์
    public mutating func enqueue(element: T) {
        data.append(element)
    }
    
    //MARK : - ์ํ ๋ฒํผ๋ฅผ ์ํ ๋์ฐ๋ฏธ ๋ฉ์๋ ๊ตฌํ
    // ๋ฒํผ๋ฅผ ์ฌ์ค์ ํด ๋น ์ํ๊ฐ ๋๊ฒ ํจ
    public mutating func clear() {
        data.removeAll()
    }
    
    
    // ํ์ ์๋ ์์์ ์๋ฅผ ๋ฐํ
    // 'count'๋ ํ์ ์๋ ์์์ ์
    public var count: Int {
        return data.count
    }
    
    // ํ์ ์ฉ๋์ ๋ฐํ
    public var capacity: Int {
        get {
            return data.capacity
        }
        set {
            data.reserveCapacity(newValue)
        }
    }
    
    // ํ๊ฐ ๊ฝ ์ฐผ๋์ง ํ์ธ
    // - ๋ฐํ๊ฐ : ํ๊ฐ ๊ฝ ์ฐฌ ๊ฒฝ์ฐ 'True'๋ฅผ ๋ฐํ, ๊ทธ๋ ์ง ์์ผ๋ฉด 'false' ๋ฐํ
    public func isFull() -> Bool {
        return count == data.capacity
    }
    
    // Check if the queue is empty
    // ๋ฐํ๊ฐ : ํ๊ฐ ๋น์ด์๋ ๊ฒฝ์ฐ 'ture', ์๋๋ฉด 'false' ๋ฐํ
    public func isEmpty() -> Bool {
        return data.isEmpty
    }
}

/*
 
 ๐ง ํ ๋ฐ์ดํฐ ๊ตฌ์กฐ์ ๊ตฌํ์ ๋น๊ต์  ๊ฐ๋จ๐ง  :
 ๋ฐฐ์ด์ wrappingํ๊ณ  ์ ๊ทผ์ ๋ฉ์๋๋ฅผ ํตํด ํ์ ์์ฑ์ ๋ํ๋ด๋๋ก ํจ
 ์ด๋ ๋ฐฐ์ด์ ์ฉ๋์ ํฌํจ๋๋ ๋ฐ์ดํฐ์ ์์ ๋ฐ๋ผ ๋์ ์ผ๋ก ์กฐ์ ๋จ
 
 */

// ์์ 

var queue = Queue<Int>()
// []
queue.enqueue(element: 100)
// [100]
queue.enqueue(element: 120)
// [100, 120]
queue.enqueue(element: 125)
// [100, 120, 125]
queue.enqueue(element: 130)
// [100, 120, 125, 130]


let x = queue.dequeue()
// Optional(100)

// ํด๋น ์์๋ฅผ ์ ๊ฑฐํ์ง ์๊ณ  ๋ค์ ์์๋ฅผ ํ์ธ
let y = queue.peek()
// Optional(120)
// dequeue๋ก 120 ์์ ์ ๊ฑฐํ๊ธฐ
let z = queue.dequeue()
// Optional(120)


// โ ํ๋กํ ์ฝ
/*
 CustomerStringConvertible, CustomerDebugStringConvertible
 ๋ ๊ฐ์ง ํ๋กํ ์ฝ์ ๋ง๋ค์ด์ ํ์ ๊ฐ์ ์ถ๋ ฅํ  ๋ ์ข ๋ ์ดํดํ๊ธฐ ์ฌ์ด ์ด๋ฆ์ ๋ฐํํ๋๋ก ํจ
 */

extension Queue: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        return data.description
    }
    
    public var debugDescription: String {
        return data.debugDescription
    }
}

// ์ํ์ค๋ก ํ์ ๊ตฌ์กฐ๋ฅผ ๋ง๋ฆ
public init <S: Sequence>(_ elements: S) where
    S.Iterator.Element == T {
    data.append(contentsOf: elements)
}

extension Queue: ExpressibleByArrayLiteral {
    // ๋ฐฐ์ด ๋ฆฌํฐ๋ด์ ํตํด ํ ๊ตฌ์กฐ๋ฅผ ๋ง๋ฆ
    public init(arrayLiteral elements: T...) {
        self.init(elements)
    }
}

// ๐๋ค๋ฅธ ์ปฌ๋ ์ ํ์์์ ๊ทธ๋ค๋ , for...in ๋ฃจํ์์ ํ๋ฅผ ์ฌ์ฉํ  ์ ์๋๋ก ์ค๋น!!

extension Queue: Sequence {
    // ์ด๋ฒ ์ํ์ค๋ฅผ ์ํํ๋ ๋ฐ๋ณต๊ธฐ๋ฅผ ๋ฐํ
    // - ๋ณต์ก์ฑ: O(1).
    public func generate() -> AnyIterator<T> {
        AnyIterator(IndexingIterator(_elements: data.lazy))
    }
}

// index๊ฐ ์ง์  ๋ฒ์ ๋ด ๊ฐ์ธ์ง ํ์ธ
private func checkIndex(index: Int) {
    if index < 0 || index > count {
        fatalError("Index out of range")
    }
}

extension Queue: MutableCollection {
    public var startIndex: Int {
        return 0
    }
    
    public var endIndex: Int {
        return count - 1
    }
    
    // ํด๋น ์ธ๋ฑ์ค์ ๋ค์ ์์น ๊ฐ์ ๋ฐํ
    public func index(after i: Int) -> Int {
        return data.index(after: i)
    }
    
    public subscript(index: Int) -> T {
        get {
            checkIndex(index)
            return data[index]
        }
        set {
            checkIndex(index)
            data[index] = newValue
        }
    }
}

// ์์ ๋ก ํ๋กํ ์ฝ ์๋ํ๋์ง ํ์ธ

// ArrayLiteral ๋ฌธ๋ฒ ์ฌ์ฉ
var q1: Queue<Int> = [1,2,3,4,5]

// q1์์ ๊ฐ์ ธ์จ SequenceType์ ๋ฐ๋ ์ด๊ธฐํ ๋ฉ์๋ฅผ ์ด์ฉํด์ ์๋ก์ด ํ๋ฅผ ์์ฑ
var q2 = Queue<Int>(q1)

let q1x = q1.dequeue()
// q1x = 1

q2.enqueue(55)
// q2 = [1,2,3,4,5,55]

