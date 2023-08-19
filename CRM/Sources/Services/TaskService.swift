//
//  TaskService.swift
//  CRM
//
//  Created by Aleksei Chudin on 19.08.2023.
//

import Foundation

class TaskService {
    
    private (set) var tasks: [TaskEntity] = [
        TaskEntity(id: "2109i1290", title: "Подготовить договор для подписания", deadline: Date()+78456, assignor: "Слепкова Марина Александровна", assignee: "Петров Иван", status: .free, type: .task, priority: .high),
        TaskEntity(id: "20349856", title: "Создать встречу по изучению проекта", deadline: Date()-1000000, assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .free, type: .call, priority: .middle),
        TaskEntity(id: "09847536", title: "Подготовить презентацию по проекту", deadline: Date()+7856456, assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .inWork, type: .task, priority: .high),
        TaskEntity(id: "18257463", title: "Позвонить ответственному лицу", deadline: Date()+78456, assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .inWork, type: .call, priority: .low),
        TaskEntity(id: "63475683", title: "Изучить проект", deadline: Date()-78456, assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .completed, type: .meeting, priority: .middle),
        TaskEntity(id: "23547263", title: "Подвести итоги по проекту", deadline: Date()+7845, assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .free, type: .call, priority: .notAvailable),
        TaskEntity(id: "09847536", title: "Создать встречу по анализу проекта", deadline: Date()-78456, assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .declined, type: .meeting, priority: .notAvailable),
        TaskEntity(id: "09847536", title: "Созвониться с поставщиками услуг", deadline: Date()+11111, assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .inWork, type: .meeting, priority: .notAvailable),
        TaskEntity(id: "09847536", title: "Созвониться с поставщиками услуг", deadline: Date()-25832, assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .inWork, type: .meeting, priority: .notAvailable),
        TaskEntity(id: "09847536", title: "Подготовить материалы к инвест. комитету", deadline: Date()-124623, assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .inWork, type: .meeting, priority: .notAvailable),
        TaskEntity(id: "63475683", title: "Изучить проект", deadline: Date()+3465387, assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .inWork, type: .meeting, priority: .middle),
        TaskEntity(id: "23547263", title: "Подвести итоги по проекту", deadline: Date(), assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .inWork, type: .call, priority: .notAvailable),
        TaskEntity(id: "09847536", title: "Создать встречу по анализу проекта", deadline: Date()-89732, assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .inWork, type: .meeting, priority: .notAvailable),
        TaskEntity(id: "09847536", title: "Созвониться с поставщиками услуг", deadline: Date()+4735643, assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .inWork, type: .meeting, priority: .notAvailable),
        TaskEntity(id: "09847536", title: "Созвониться с поставщиками услуг", deadline: Date()-3456, assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .inWork, type: .meeting, priority: .notAvailable),
        TaskEntity(id: "09847536", title: "Подготовить материалы к инвест. комитету", deadline: Date()+843625, assignor: "Долуханов Филипп Сергеевич", assignee: "Долуханов Филипп Сергеевич", status: .inWork, type: .meeting, priority: .notAvailable)
    ]
    var updateHandlers = [() -> Void]()
    
    func addTask(task: TaskEntity) {
        tasks.append(task)
        notify()
    }
    
    func removeTask(task: TaskEntity) {
        tasks.removeAll(where: { $0.id == task.id })
        notify()
    }
    
    private func notify() {
        updateHandlers.forEach { $0() }
    }
}
